;;; behave.el --- Emacs Lisp Behaviour-Driven Development framework

;; Copyright (C) 2007 Phil Hagelberg

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 1, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; A copy of the GNU General Public License can be obtained from the
;; Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Description:

;; behave.el allows you to write executable specifications for your
;; Emacs Lisp code. Executable specifications allow you to check that
;; your code is working correctly in an automated fashion that you can
;; use to drive the focus of your development. (It's related to
;; Test-Driven Development.) You can read up on it at
;; http://behaviour-driven.org.

;; Specifications and contexts both must have docstrings so that when
;; the specifications aren't met it is easy to see what caused the
;; failure.  Each specification should live within a context. In each
;; context, you can set up relevant things to test, such as necessary
;; buffers or data structures. (Be sure to use lexical-let for setting
;; up the variables you need--since the specify macro uses lambdas,
;; closures will be made for those variables.) Everything within the
;; context is executed normally.

;; Each context can be tagged with the TAG form. This allows you to
;; group your contexts by tags. When you execute the specs, M-x behave
;; will ask you to give some tags, and it will execute all contexts
;; that match those tags.

;; When you want to run the specs, evaluate them and press M-x
;; behave. Enter the tags you want to run (or "all"), and they will be
;; executed with results in the *behave* buffer. You can also do M-x
;; specifications to show a list of all the specified behaviours of
;; the code.

;;; Implementation

;; Contexts are stored in the *behave-contexts* list as structs. Each
;; context has a "specs" slot that contains a list of its specs, which
;; are stored as closures. The expect form ensures that expectations
;; are met and signals behave-spec-failed if they are not.

;; Warning: the variables CONTEXT and SPEC-DESC are used within macros
;; in such a way that they could shadow variables of the same name in
;; the code being tested. Future versions will use gensyms to solve
;; this issue, but in the mean time avoid relying upon variables with
;; those names.

;;; To do:

;; See open tickets on my Trac:
;; http://dev.technomancy.us/phil/query?status=new&status=assigned&status=reopened&component=behave&order=priority

;; Main issues: more expect predicates and protected-let

;;; Example usage:

;; See meta.el for specifications for behave.el. Evaluate meta.el and
;; M-x specifications meta RET to see the specifications explained.

(require 'cl)

(defvar *behave-contexts* '()
  "A list of contexts and their specs.")

(defvar *behave-default-tags* "all")

(defstruct context description tags (specs '()) refreshing-vars)

(put 'behave-spec-failed 'error-conditions '(failure))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Core Macros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro context (description &rest body)
  "Defines a context for specifications to run in."
  (setq *behave-contexts* (delete (context-find description) *behave-contexts*))
  `(lexical-let ((context (make-context)))
     (setf (context-description context) ,description)
     (add-to-list '*behave-contexts* context)
     ,@body))

(defmacro specify (description &rest body)
  "Add a specification and its description to the current context."
  `(push (lambda () ,description (let ((spec-desc ,description)) 
			      ,@body)) (context-specs context)))

(defmacro expect (actual &optional predicate expected)
  "State expectations the code should fulfill."
  (case predicate
    ((equals equal)
     `(if (not (equal ,actual ,expected))
	  (signal 'behave-spec-failed (list (context-description context) spec-desc))))
    ((member member-of)
     `(if (not (member ,actual ,expected))
	  (signal 'behave-spec-failed (list (context-description context) spec-desc))))
    (t
     `(or ,actual
	  (signal 'behave-spec-failed (list (context-description context) spec-desc))))))

(defmacro tag (&rest tags)
  "Give a context tags for easy reference. (Must be used within a context.)"
  `(setf (context-tags context) (append '(,@tags) (context-tags context))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Context-management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun behave-clear-contexts ()
  (interactive)
  (setq *behave-contexts* '())
  (message "Behave: contexts cleared"))

(defun context-find (description)
  "Find a context by its description."
  (find description *behave-contexts* :test (lambda (description context) (equal description (context-description context)))))

(defun context-find-by-tag (tag)
  (remove-if (lambda (context) (not (find tag (context-tags context))))
	     *behave-contexts*))

(defun context-find-by-tags (tags)
  (if (find 'all tags)
      *behave-contexts*
    (delete nil (remove-duplicates (mapcan 'context-find-by-tag tags)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Execution
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun behave (&optional tags)
  "Execute all contexts that match given tags"
  (interactive)
  (let ((tags-string (or tags (read-string (concat "Execute specs matching these tags (default " *behave-default-tags* "): ")
					   nil nil *behave-default-tags*)))
	(start-time (cadr (current-time)))
	(failures nil)
	(spec-count 0))
    (setq *behave-default-tags* tags-string) ; update default for next time
    (with-output-to-temp-buffer "*behave*"
      (princ (concat "Running specs tagged \"" tags-string "\":\n\n"))
      (dolist (context (context-find-by-tags (mapcar 'intern (split-string tags-string " "))))
	    (execute-context context))
      (behave-describe-failures failures start-time))))

(defun execute-context (context)
  (condition-case failure
      (mapcar #'execute-spec (reverse (context-specs context)))
    (error (princ "E")
	   (add-to-list 'failures (list "Error:" failure) t))
    (failure (princ "F")
	     (add-to-list 'failures (cdr failure) t))))

(defun execute-spec (spec)
  (incf spec-count)
  (funcall spec)
  (princ "."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reporting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun behave-describe-failures (failures start-time)
  (princ (concat "\n\n" (number-to-string (length failures)) " problem" (unless (= 1 (length failures)) "s") " in " 
		 (number-to-string spec-count)
		 " specification" (unless (= 1 spec-count) "s") 
		 ". (" (number-to-string (- (cadr (current-time)) start-time)) " seconds)\n\n"))
  (dolist (failure failures)
    (princ failure)
    (princ "\n\n")))

(defun specifications (&optional tags)
  "Show specifications for all contexts that match given tags"
  (interactive)
  (let ((tags-string (or tags (read-string (concat "Show specs matching these tags (default " *behave-default-tags* "): ")
					   nil nil *behave-default-tags*))))
    (with-output-to-temp-buffer "*behave*"
      (princ "Specifications:\n")
      (mapcar #'specify-context (context-find-by-tags (mapcar 'intern (split-string tags-string " ")))))))

(defun specify-context (context)
  (princ (concat "\n" (context-description context) "...\n"))
  (dolist (spec (context-specs context))
    (princ (concat " * " (caddr spec) "\n"))))

(require 'behave-support)

(provide 'behave)