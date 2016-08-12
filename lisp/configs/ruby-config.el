(load-library "ruby-mode-config")

;;; ============================================================
;;; RUBY
;; (require 'ruby-mode)
;; (require 'ruby-electric)

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

;;;
;;; Crystal
;;;
(autoload 'crystal-mode "crystal-mode" "Major mode for crystal files" t)
(add-to-list 'auto-mode-alist '("\\.cr$" . crystal-mode))
(add-to-list 'interpreter-mode-alist '("crystal" . crystal-mode))
(add-hook 'crystal-mode-hook
          (lambda ()
            (require 'ruby-electric)
            (ruby-electric-mode t)))
