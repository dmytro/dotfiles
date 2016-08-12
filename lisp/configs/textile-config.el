;;;
;;; textile mode
;;; http://dev.nozav.org/textile-mode.html

(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
(defun textile-custom () "textile-mode-hook"
  (set-variable 'fill-column' 72)
  )
(add-hook 'textile-mode-hook '(lambda() (textile-custom)))
