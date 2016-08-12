;; -*- mode: Lisp; fill-column: 75; comment-column: 50; -*-
;;;


(setq load-path (append '("~/.lisp") load-path))
(setq load-path (append '("~/.lisp/configs") load-path))

(load-library "install-packages-config")   ; Automatically install required
                                           ; packages on startup

(load-library "keys-config")                      ; All keys combinations,
                                                  ; keystrokes

(load-library "ux-config")                        ; Menues, views, tabs, font-lock

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))



(if (eq system-type "darwin")
    (set-input-method 'ucs)) ;; to make ^-S work on macOSX

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;;; MODES
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))
;;;
;;; YAML
;;;
                                                  ;(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;;;
;;; CSS
;;;
;(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css\\'" . css-mode) auto-mode-alist))

;;; SystemD, Fleet
(setq auto-mode-alist (cons '("\\.service\\'" . conf-unix-mode) auto-mode-alist))

;;; Language modes
(load-library "perl-config")
(load-library "shell-config")
(load-library "ruby-config")

;;
;; PYTHON
;;
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))

;;;
;;; HTML helper
;;;
;; (autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-mode) auto-mode-alist))
;; (setq html-helper-do-write-file-hooks t)
;; (setq html-helper-build-new-buffer t)
;; (setq html-helper-use-expert-menu 't) ; full menu
					;Apr 21 1999


;; ;; Projectile
;; (projectile-global-mode)
;; ;; (add-hook 'ruby-mode-hook 'projectile-on)
;; ;; Display ido results vertically, rather than horizontally
;; (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;; (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
;;   (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
;;     (define-key ido-completion-map (kbd "Down") 'ido-next-match)
;;     (define-key ido-completion-map (kbd "Up") 'ido-prev-match)
;;     )
;; (add-hook 'ido-setup-hook 'ido-define-keys)

;; (global-set-key (kbd "C-x C-d") 'projectile-dired)

;; (add-hook 'projectile-mode-hook 'projectile-rails-on)

;; ;;  IDO mode
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)
;; (setq ido-file-extensions-order '(".rb" ".erb" ".yml" ))
;; (defcustom projectile-rails-keymap-prefix (kbd "M-r")
;;   "`projectile-rails-mode' keymap prefix."
;;   :group 'projectile-rails
;;   :type 'string)


;; Missing from ruby-mode.el, see https://groups.google.com/group/emacs-on-rails/msg/565fba8263233c28
(defun ruby-insert-end ()
  "Insert \"end\" at point and reindent current line."
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

(add-hook 'ruby-mode-hook
          (lambda ()
            (require 'ruby-electric)
            (ruby-electric-mode t)))

;;; ----------------------------------------
;;; -- Ruby mode

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
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

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))
(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(setq-default puppet-indent-level 4)
(setq-default puppet-indent-tabs-mode nil)
;;;
;;; Cheetah-Mode is for editing snippets in Cobbler
;;;
;;; from here: http://www.emacswiki.org/emacs/CheetahMode
;;;
(define-derived-mode cheetah-mode html-mode "Cheetah"
  (make-face 'cheetah-variable-face)
  (font-lock-add-keywords
   nil
   '(
     ("\\(#\\(from\\|else\\|include\\|extends\\|set\\|def\\|import\\|for\\|if\\|end\\)+\\)\\>" 1 font-lock-type-face)
     ("\\(#\\(from\\|for\\|end\\)\\).*\\<\\(for\\|import\\|def\\|if\\|in\\)\\>" 3 font-lock-type-face)
     ("\\(##.*\\)\n" 1 font-lock-comment-face)
     ("\\(\\$\\(?:\\sw\\|}\\|{\\|\\s_\\)+\\)" 1 font-lock-variable-name-face))
   )
  (font-lock-mode 1)
  )
(setq auto-mode-alist (cons '( "\\.tmpl\\'" . cheetah-mode ) auto-mode-alist ))
;(setq comment-start "##")
;(setq comment-end "")

;;; Disabled - hangs emacs
;;; (load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxhtml/autostart.el")
;;; (load "/Users/dmytro/.lisp/jekyll/jekyll-mumamo.el")
;;; (load "/Users/dmytro/.lisp/jekyll/jekyll.el")

(setq initial-scratch-message nil)

;;; Hangs
;;; (require 'tramp)
;;; (setq tramp-default-method "ssh")
;;; (defadvice tramp-maybe-open-connection
;;;   (around set-process-connection-type)
;;;   "Set process-connection-type to pty."
;;;   (let ((process-connection-type 'pty))
;;;     ad-do-it))
;;; (ad-activate 'tramp-maybe-open-connection)

(require 'json-mode)
(autoload 'json-mode "json-mode" "Major mode for editing JSON data")
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
;;;
;;; Markdown mode
;;;
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

(defun markdown-custom () "markdown-mode-hook"
       (set-variable 'fill-column' 72)
       (setq tab-width 2)
       (local-set-key [M-right] 'forward-word)
       (local-set-key [M-left] 'backward-word)
  )

(add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))

;;;
;;; textile mode
;;; http://dev.nozav.org/textile-mode.html

(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
(defun textile-custom () "textile-mode-hook"
  (set-variable 'fill-column' 72)
  )
(add-hook 'textile-mode-hook '(lambda() (textile-custom)))

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

;; (require 'haml-mode)
;; (require 'sass-mode)
;; (require 'scss-mode)
;; (require 'slim-mode)
(defun disable-smartparens ()
  (smartparens-mode 0)
  )

(add-hook 'slim-mode-hook 'disable-smartparens)   ; TO be able to indemt/unindent with >,<
(add-hook 'yaml-mode-hook 'disable-smartparens)   ; TO be able to indemt/unindent with >,<

;; Electic indent - disable indenting previos line
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)
             (set (make-local-variable 'electric-indent-mode) nil)
             (electric-indent-local-mode -1)      ; For 24.4, see http://goo.gl/aURErf
             )
          )

(add-hook 'slim-mode-hook
          '(lambda ()
             (define-key slim-mode-map "\C-m" 'newline-and-indent)
             (set (make-local-variable 'electric-indent-mode) nil)
             (electric-indent-local-mode -1)      ; For 24.4, see http://goo.gl/aURErf
             )
          )

;;  SASS mode
(setq scss-compile-at-save 'nil)

(require 'snippet)
;;; Server
(server-start)

;; (setq linum-format "%4d\u2502 ")
(global-hl-line-mode 1)
; (set-face-background hl-line-face "#E0FFE0")

;; (show-paren-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;
;;; Colors
;;;

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-deep-blue)))
;;;
;;; Switch buffers
;;; --------------------------------------------
(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^\\*"))
;; http://www.emacswiki.org/emacs/IswitchBuffers
(defun iswitchb-local-keys ()
      (mapc (lambda (K)
	      (let* ((key (car K)) (fun (cdr K)))
    	        (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	    '(("<right>" . iswitchb-next-match)
	      ("<left>"  . iswitchb-prev-match)
	      ("<up>"    . ignore             )
	      ("<down>"  . ignore             ))))

(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)

(global-visual-line-mode 1) ; 1 for on, 0 for off.

;; other window - disable split
(setq split-width-threshold nil)
(setq split-height-threshold nil)
(put 'dired-find-alternate-file 'disabled nil)

;; Configs
(load-file "~/.lisp/configs/enh-ruby-config.el")
(load-file "~/.lisp/configs/autocomplete.el")
(load-file "~/.lisp/configs/projectile.el")

(defun align-to-equals (begin end)
  "Align region to equal signs"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))
(global-set-key (kbd "C-c a =") 'align-to-equals)

(set-default-font "-apple-Inconsolata-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1")

;; http://stackoverflow.com/questions/2284703/emacs-how-to-disable-file-changed-on-disk-checking
(global-auto-revert-mode)

(set-variable 'vc-follow-symlinks' t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Docker files

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))
