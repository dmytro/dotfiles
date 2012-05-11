(setq load-path (append '("~/.lisp") load-path))


;;;
;;; KEYS
;;;
(global-set-key "\C-g" 'goto-line)
(local-set-key "\C-g" 'goto-line)
(local-set-key "\C-x\C-o" 'other-window)
(global-set-key "\C-x\C-o" 'other-window)
(global-set-key "\M-`" 'other-window)

;;; Fulls screen mode on/off
(local-set-key (kbd "M-RET") 'toggle-fullscreen)
(global-set-key (kbd "M-RET") 'toggle-fullscreen)

;; n X Wndow C-z and C-xC-z are bound to ncofng wndo whch s dsturbnng for me
;;iconify-or-deiconify-frame
(global-unset-key "\C-z")
(local-unset-key "\C-z")
(global-unset-key "\C-x\C-z")
(local-unset-key "\C-x\C-z")
					
				; undo to C-x C-u
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
(set-cursor-color "red")
(set-mouse-color "red")
(set-background-color "ivory")
(set-foreground-color "navy")

(setq truncate-partial-width-windows 'nil)
(scroll-bar-mode 'nil)
(tool-bar-mode 'nil)
(menu-bar-mode 'nil)
(setq column-number-mode t) ;; Show column numbers
(setq line-number-mode 1) ;; Show line numbers
(setq-default indent-tabs-mode nil) ;; Use spaces for tabs
(setq visible-bell t) ;; Visable bells
(delete-selection-mode 1)
(setq transient-mark-mode 't)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(setq auto-save-list-file-prefix (concat "/tmp/." (user-login-name) "-emacs-autosave-")) ;; Auto save directory


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
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))


;;;
;;; CSS
;;; 
(autoload 'css-mode "css-mode")
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

;; RUBY
(require 'ruby-mode)
(require 'ruby-electric)
 
(defun ruby-eval-buffer () (interactive)
    "Evaluate the buffer with ruby."
    (shell-command-on-region (point-min) (point-max) "ruby"))
 
(defun my-ruby-mode-hook ()
  (setq standard-indent 4)
  (pabbrev-mode t)
  (ruby-electric-mode t)
  (define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer))
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
 
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

(add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))

;; -- Ruby mode

(kill-buffer "*scratch*") ;; Kill default scratch buffer



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
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "ivory" :foreground "navy" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :family "apple-monaco")))))

(defun toggle-fullscreen () 
  (interactive) 
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) 
                                           nil 
                                           'fullboth))) 
; (global-set-key [(meta return)] toggle-fullscreen)
