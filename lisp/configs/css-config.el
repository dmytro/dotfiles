;;;
;;; CSS
;;;
;(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css\\'" . css-mode) auto-mode-alist))

;; (require 'haml-mode)
;; (require 'sass-mode)
;; (require 'scss-mode)

;;  SASS mode
(setq scss-compile-at-save 'nil)
