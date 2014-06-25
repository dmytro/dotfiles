;; -*- mode: Lisp; fill-column: 75; comment-column: 50; -*-
;;; ==================================================================
;;;  Install required packages
;;;
(defvar prelude-packages

  '(coffee-mode gist haml-mode inf-ruby markdown-mode ruby-mode smartparens
                rhtml-mode ruby-electric rinari flymake-ruby json-mode
                textile-mode projectile python sass-mode rainbow-mode
                scss-mode sass-mode css-mode slim-mode color-theme
                volatile-highlights yaml-mode yari snippet pabbrev ag
                enh-ruby-mode autopair flex-autopair)

  "A list of packages to ensure are installed at launch.")
;; --------------------------------------------

(require 'cl)                                     ;for loop macro
(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;
(defun prelude-packages-installed-p ()
 (loop for p in prelude-packages
       when (not (package-installed-p p)) do (return nil)
       finally (return t)))
;
(unless (prelude-packages-installed-p)
 ;; check for new packages (package versions)
 (message "%s" "Emacs Prelude is now refreshing its package database...")
 (package-refresh-contents)
 (message "%s" " done.")
 ;; install the missing packages
 (dolist (p prelude-packages)
   (when (not (package-installed-p p))
     (package-install p))))

(provide 'prelude-packages)
;;; ==================================================================
;;; prelude-packages.el ends here

(require 'volatile-highlights)
(volatile-highlights-mode t)

(setq load-path (append '("~/.lisp") load-path))

;;;
;;; KEYS
;;;
(global-set-key "\C-g" 'goto-line)
(local-set-key "\C-g" 'goto-line)
(local-set-key "\C-x\C-o" 'other-window)
(global-set-key "\C-x\C-o" 'other-window)
(global-set-key "\M-`" 'other-window)

;;; Naviagating with M-up/down - previos window
;;; http://nex-3.com/posts/45-efficient-window-switching-in-emacs

(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-`") 'select-next-window)
(global-set-key (kbd "M-<up>") 'select-next-window)
(global-set-key (kbd "M-<down>")  'select-previous-window)

(global-set-key [C-left] 'windmove-left)          ; move to left windnow
(global-set-key [C-right] 'windmove-right)        ; move to right window
(global-set-key [C-up] 'windmove-up)              ; move to upper window
(global-set-key [C-down] 'windmove-down)          ; move to downer window

;;; These are defaults anyway
(global-set-key [M-right] 'forward-word)
(global-set-key [M-left]  'backward-word)

;;; Full screen mode on/off
(local-set-key (kbd "M-RET") 'toggle-fullscreen)
(global-set-key (kbd "M-RET") 'toggle-fullscreen)

;; In X Window C-z and C-xC-z are bound to ncofng wndo whch s dsturbnng for me
;;iconify-or-deiconify-frame
(global-unset-key "\C-z")
(local-unset-key "\C-z")
(global-unset-key "\C-x\C-z")
(local-unset-key "\C-x\C-z")

;;; undo to C-x C-u
(local-set-key "\C-x\C-u" 'advertised-undo)
(global-set-key "\C-x\C-u" 'advertised-undo)
(global-set-key "\M-_" 'advertised-undo) ; Meta-_
(global-set-key "\M-z" 'advertised-undo) ; Meta-z

					;  other window -> C-x C-o (instead of C-x o)
(local-set-key "\C-x\C-o" 'other-window)
(global-set-key "\C-x\C-o" 'other-window)

;;;
;;; ENVIRONMENT/ TOOLBARS / LAYOUT / VIEW
;;;
(setq inhibit-start-screen 1)  ;; do not open *GNU Emacs" buffer
(setq inhibit-splash-screen 1)

(setq truncate-partial-width-windows 'nil)
(scroll-bar-mode 0)
(tool-bar-mode 0)
;(menu-bar-mode 0)
(setq column-number-mode t) ;; Show column numbers
(setq line-number-mode 1) ;; Show line numbers
(setq-default indent-tabs-mode nil) ;; Use spaces for tabs
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq visible-bell t) ;; Visable bells
(delete-selection-mode 1)
(setq transient-mark-mode 't)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;;; 2009/03/30
;;; http://groups.google.com/group/carbon-emacs/browse_thread/thread/537c1d730453c94f?pli=1
(setq mac-command-modifier 'meta)
(setq x-select-enable-clipboard t)
(setq mac-option-modifier 'meta)
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

;;;
;;; PERL
;;;

;(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq cperl-hairy t)
(setq auto-mode-alist (append '(("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode))  auto-mode-alist ))
(setq interpreter-mode-alist (append interpreter-mode-alist '(("miniperl" . cperl-mode))))
(setq perl-tab-to-comment 't)
(setq exec-path (append '("/usr/local/bin") exec-path))

;;
;; SHELL
;;
(if (file-exists-p "/bin/bash") (setq explicit-shell-file-name "/bin/bash"))
(if (file-exists-p "/bin/zsh")  (setq explicit-shell-file-name "/bin/zsh"))

;;
;; PYTHON
;;
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))

;;;
;;; HTML helper
;;;
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
(setq html-helper-do-write-file-hooks t)
(setq html-helper-build-new-buffer t)
(setq html-helper-use-expert-menu 't) ; full menu
					;Apr 21 1999

;;; ============================================================
;;; RUBY
;; (require 'ruby-mode)
;; (require 'ruby-electric)

(load-file "~/.lisp/configs/enh-ruby-config.el")
(load-file "~/.lisp/configs/autocomplete.el")
;(load-file "~/.lisp/configs/ruby-mode-config.el")

(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(sp-with-modes '(rhtml-mode)
  (sp-local-pair "<" ">")
  (sp-local-pair "<%" "%>"))

;; (require 'ruby-block)
;; (ruby-block-mode t)
;; (setq ruby-block-highlight-toggle 'overlay)

;; Rinari Mode (Rails)
(add-to-list 'load-path "~/.lisp/rinari")
(add-to-list 'load-path "~/.lisp/rinari/rhtml")
(require 'rinari)

(defun my-rhtml-mode-hook ()
  (auto-fill-mode -1)
  (flyspell-mode -1)
  (longlines-mode -1))
(add-hook 'rhtml-mode-hook 'my-rhtml-mode-hook)

(require 'rinari)
;;(setq auto-mode-alist (cons '("\\.rhtml\\'" . rhtml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.erb\\'" . rhtml-mode) auto-mode-alist))


;; Projectile
(projectile-global-mode)
;; (add-hook 'ruby-mode-hook 'projectile-on)
;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "Down") 'ido-next-match)
    (define-key ido-completion-map (kbd "Up") 'ido-prev-match)
    )
(add-hook 'ido-setup-hook 'ido-define-keys)

(global-set-key (kbd "C-x C-d") 'projectile-dired)

(add-hook 'projectile-mode-hook 'projectile-rails-on)

;;  IDO mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-file-extensions-order '(".rb" ".erb" ".yml" ))


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
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/")))))

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
  (set-variable 'fill-column' 1000)
  )
(add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))

;;;
;;; textile mode
;;; http://dev.nozav.org/textile-mode.html

(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
(defun textile-custom () "textile-mode-hook"
  (set-variable 'fill-column' 1000)
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

;; Electic indent - disable indenting previos line
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent))
          )

(add-hook 'slim-mode-hook
          '(lambda ()
             (define-key slim-mode-map "\C-m" 'newline-and-indent))
          )

;;  SASS mode
(setq scss-compile-at-save 'nil)

(require 'snippet)
;;; Server
(server-start)

;; (setq linum-format "%4d\u2502 ")
(global-hl-line-mode 1)
; (set-face-background hl-line-face "#E0FFE0")
(custom-set-variables '(show-trailing-whitespace t))
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
(global-set-key "\C-x\C-b" 'buffer-menu) ; Open buffer list in the same buffer, intead of other
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

;; http://stackoverflow.com/questions/11623189/how-to-bind-keys-to-indent-unindent-region-in-emacs/11624677#11624677
;;
(defun my-indent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 2))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -2))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(sp-pair "<" nil :actions :rem)
(sp-pair ">" nil :actions :rem)
(global-set-key ">" 'my-indent-region)
(global-set-key "<" 'my-unindent-region)
