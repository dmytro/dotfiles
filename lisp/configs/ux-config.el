(set-default-font "-apple-Inconsolata-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1")
;;;
;;; ENVIRONMENT/ TOOLBARS / LAYOUT / VIEW
;;;
(setq inhibit-start-screen 1)  ;; do not open *GNU Emacs" buffer
(setq inhibit-splash-screen 1)

(global-hl-line-mode 1)
(global-font-lock-mode t)
;(set-face-background hl-line-face "#E0FFE0")
;; http://stackoverflow.com/questions/2284703/emacs-how-to-disable-file-changed-on-disk-checking
(global-auto-revert-mode)
(global-visual-line-mode 1) ; 1 for on, 0 for off.

;; (setq truncate-partial-width-windows 'nil)
(setq initial-scratch-message nil)
(scroll-bar-mode 0)
(tool-bar-mode 0)
;(menu-bar-mode 0)
(setq column-number-mode t) ;; Show column numbers
(setq line-number-mode 1) ;; Show line numbers
;; (setq linum-format "%4d\u2502 ")
(setq-default indent-tabs-mode nil) ;; Use spaces for tabs
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq visible-bell t) ;; Visable bells
(delete-selection-mode 1)
(setq x-select-enable-clipboard t)
(setq transient-mark-mode 't)

(setq font-lock-maximum-decoration t)

(set-variable 'vc-follow-symlinks' t)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))

;;;
;;; Colors
;;;
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-deep-blue)))

;;;
;;; Switch buffers
;;; --------------------------------------------
(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^\\*"))
;; http://www.emacswiki.org/emacs/IswitchBuffers
(defun iswitchb-local-keys ()
      (mapc (lambda (K)
	      (let* ((key (car K)) (fun (cdr K)))
    	        (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	    '(("<right>" . iswitchb-next-match)
	      ("<left>"  . iswitchb-prev-match)
	      ("<up>"    . ignore             )
	      ("<down>"  . ignore             ))))

(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)


;; other window - disable split
(setq split-width-threshold nil)
(setq split-height-threshold nil)
(put 'dired-find-alternate-file 'disabled nil)

(load-library "autocomplete")

;; (show-paren-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
