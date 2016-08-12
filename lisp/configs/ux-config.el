;;;
;;; ENVIRONMENT/ TOOLBARS / LAYOUT / VIEW
;;;
(setq inhibit-start-screen 1)  ;; do not open *GNU Emacs" buffer
(setq inhibit-splash-screen 1)

;; (setq truncate-partial-width-windows 'nil)
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

(require 'volatile-highlights)
(volatile-highlights-mode t)

(setq x-select-enable-clipboard t)
