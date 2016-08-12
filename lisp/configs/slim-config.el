;; (require 'slim-mode)
(defun disable-smartparens ()
  (smartparens-mode 0)
  )

(add-hook 'slim-mode-hook 'disable-smartparens)   ; TO be able to indemt/unindent with >,<
(add-hook 'yaml-mode-hook 'disable-smartparens)   ; TO be able to indemt/unindent with >,<


(add-hook 'slim-mode-hook
          '(lambda ()
             (define-key slim-mode-map "\C-m" 'newline-and-indent)
             (set (make-local-variable 'electric-indent-mode) nil)
             (electric-indent-local-mode -1)      ; For 24.4, see http://goo.gl/aURErf
             )
          )
