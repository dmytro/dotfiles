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
