(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories
             "~/.emacs.d/elpa/auto-complete-20140605.1908/dict")
(add-to-list 'ac-dictionary-directories "~/.lisp/dict")
(ac-config-default)
;; (setq ac-ignore-case nil)
;; (setq ac-auto-start nil)
;; (ac-set-trigger-key "TAB")
(add-to-list 'ac-modes 'enh-ruby-mode)

(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(define-key ac-mode-map (kbd "M-f") 'ac-isearch)

;(add-to-list 'ac-user-dictionary "foobar@example.com")
