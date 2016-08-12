;;;
;;; YAML
;;;                                                  ;(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; Electic indent - disable indenting previos line
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)
             (set (make-local-variable 'electric-indent-mode) nil)
             (electric-indent-local-mode -1)      ; For 24.4, see http://goo.gl/aURErf
             )
          )
