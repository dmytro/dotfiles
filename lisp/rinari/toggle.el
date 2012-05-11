;;; toggle.el --- quickly open corresponding file (eg test vs impl).

;; Copyright (C) 2006-2007 by Ryan Davis

;; Author: Ryan Davis <ryand-ruby@zenspider.com>
;; Version 1.1
;; Keywords: files, extensions, convenience
;; Created: 2006-03-22
;; Compatibility: Emacs 22, 21?
;; URL(en): http://seattlerb.rubyforge.org/

;; The MIT License: http://en.wikipedia.org/wiki/MIT_License

;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Commentary:

;; This package provides the ability to quickly open a corresponding
;; file for the current buffer by using a bi-directional mapping of
;; regular expression pairs. You can select a mapping style from
;; `toggle-mapping-styles' by setting the `toggle-mapping-style'
;; variable.

;; In addition to bi-directional regular expression mapping, you may
;; also put a function (named or lambda) in the second cell of the
;; mapping cons, and that function will be called when the rule is
;; invoked. See the rails-view rule for an example.

;; There are 4 different mapping styles in this version: zentest,
;; rails-test, rails-view, and ruby. Feel free to submit more and I'll
;; incorporate them.

;;; Example Mapping (ruby style):
;;
;; blah.rb <-> test_blah.rb
;; lib/blah.rb <-> test/test_blah.rb

(defcustom toggle-mapping-styles
  '((zentest    . (("app/controllers/\\1.rb" . "test/controllers/\\1_test.rb")
		   ("app/views/\\1.rb"       . "test/views/\\1_test.rb")
		   ("app/models/\\1.rb"      . "test/unit/\\1_test.rb")
		   ("lib/\\1.rb"             . "test/unit/test_\\1.rb")))
    (rails-test . (("app/controllers/\\1.rb" . "test/functional/\\1_test.rb")
		   ("app/models/\\1.rb"      . "test/unit/\\1_test.rb")
		   ("lib/\\1.rb"             . "test/unit/test_\\1.rb")))
    (rails-view . (("app/controllers/\\(.*\\).rb" . toggle-rails-action-to-view) ; could also use a lambda here
		   ("app/views/\\(.*\\)/\\(.*\\).rhtml" . toggle-rails-view-to-action)))
    (ruby-test  . (("lib/\\1.rb"             . "test/test_\\1.rb")
		   ("\\1.rb"                 . "test_\\1.rb"))))
  "A list of (name . toggle-mapping) rules used by toggle-filename."
  :group 'toggle
  :type '(repeat (cons string string)))

(defun toggle-style (name)
  (interactive "sStyle: ")
  (let ((pairs (cdr (assoc name toggle-mapping-styles))))
    (if pairs
	(mapcar (lambda (pair)
		  (if (stringp (cdr pair)) ; pairs that contain functions aren't bidirectional
		      (cons (replace-regexp-in-string "\\\\1" "\\\\(.*\\\\)"
						      (car pair)) (cdr pair))
		    pair))
		;; each pair implictly includes its reverse
		(remove nil (append pairs
				    (mapcar (lambda (pair)
					      (if (stringp (cdr pair))
						  (cons (cdr pair) (car pair))))
					      pairs)))))))

(defcustom toggle-mapping-style
  'rails-test
  "The defaulte toggle mapping style to load when initialized."
  :group 'toggle
  :type '(symbol))

(defvar toggle-mappings (toggle-style toggle-mapping-style)
  "*The current file mappings for `toggle-filename' to use.")

(defun toggle-filename (path rules)
  "Transform a matching subpath in PATH as given by RULES.
Each element in RULES is a pair (RE . TRANS). If the regular
expression RE matches PATH, then replace-match is invoked with
TRANS. After the first successful match, this returns. If no rule
matches, it returns nil"
  (cond ((null rules) nil)
    ((string-match (caar rules) path)
     (if (stringp (cdar rules))
	 (replace-match (cdar rules) nil nil path)
       (cdar rules)))
    (t (toggle-filename path (rest rules)))))

(defun toggle-buffer (&optional mappings)
  "Opens a related file to the current buffer using matching rules.
Matches the current buffer against rules in toggle-mappings. If a
match is found, switches to that buffer."
  (interactive)
  (if (symbolp mappings) ; for toggling according to non-default mappings
      (setq mappings (toggle-style mappings)))
  (let ((mapping (toggle-filename (buffer-file-name) (or mappings toggle-mappings))))
    (if (stringp mapping)
	(find-file mapping)
      (if (functionp mapping)
	  (funcall mapping)
	(message (concat "Match not found for " (buffer-file-name)))))))

;; TODO: move implementation from Rinari to here.
(defun toggle-rails-action-to-view ()
  (message "action to view"))
(defun toggle-rails-view-to-action ()
  (message "view to action"))

(provide 'toggle)

