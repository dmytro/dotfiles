;; -*- mode: Lisp; fill-column: 75; comment-column: 50; -*-
;;;

(setq load-path (append '("~/.lisp") load-path))
(setq load-path (append '("~/.lisp/configs") load-path))

(load-library "install-packages-config")   ; Automatically install required
                                           ; packages on startup

(load-library "keys-config")                      ; All keys combinations,
                                                  ; keystrokes

(load-library "ux-config")                        ; Menues, views, tabs, font-lock, colors

(load-library "autosaves-config")

(load-library "locale-config")

;;;; MODES
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))



;;; Language modes

(load-library "crystal-config")
(load-library "css-config")                       ; SASS,SCSS too
(load-library "docker-config")
(load-library "html-config")
(load-library "json-config")
(load-library "markdown-config")
(load-library "perl-config")
(load-library "python-config")
(load-library "ruby-config")
(load-library "rust-config")
(load-library "shell-config")
(load-library "systemd-config")                   ;SystemD, Fleet
(load-library "textile-config")
(load-library "yaml-config")
;; (load-library "cheetah-config") ; Cheetah-Mode is for editing snippets in Cobbler
;; (load-library "puppet-config")
;; (load-library "slim-config")


;; (require 'snippet)
;;; Server
;; (server-start)

(load-library "projectile")





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CUSTOM
;;  Generated stuff

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(column-number-mode t)
 '(line-number-mode 1)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ALL DISABLE STUFF
;; For reference



;;; Disabled - hangs emacs
;;; (load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxhtml/autostart.el")
;;; (load "/Users/dmytro/.lisp/jekyll/jekyll-mumamo.el")
;;; (load "/Users/dmytro/.lisp/jekyll/jekyll.el")

;;; Hangs
;;; (require 'tramp)
;;; (setq tramp-default-method "ssh")
;;; (defadvice tramp-maybe-open-connection
;;;   (around set-process-connection-type)
;;;   "Set process-connection-type to pty."
;;;   (let ((process-connection-type 'pty))
;;;     ad-do-it))
;;; (ad-activate 'tramp-maybe-open-connection)

;;;
;;; Nagios mode
;;; http://michael.orlitzky.com/code/nagios-mode.php
;; (require 'nagios-mode)
;; (setq auto-mode-alist
;;     (append (list '("\\.cfg$" . nagios-mode))
;;       auto-mode-alist))

;;    ⌘T - Go to File
;;  ⇧⌘T - Go to Symbol
;;    ⌘L - Go to Line
;;  ⇧⌘L - Select Line (or expand Selection to select lines)
;;    ⌘/ - Comment Line (or Selection/Region)
;;    ⌘] - Shift Right (currently indents region)
;;    ⌘[ - Shift Left  (not yet implemented)
;;  ⌥⌘] - Align Assignments
;;  ⌥⌘[ - Indent Line
;;    ⌥↑ - Column Up
;;    ⌥↓ - Column Down
;;  ⌘RET - Insert Newline at Line's End
;;  ⌥⌘T - Reset File Cache (for Go to File)

;;; too much troubles...
;; (add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
;; (require 'textmate)
;; (textmate-mode)
