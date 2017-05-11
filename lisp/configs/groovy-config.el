;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(setq-default c-basic-offset 2)
;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          (lambda ()
            (c-set-offset 'label 2))
          )
