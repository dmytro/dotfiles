;; -*- mode: Lisp; fill-column: 75; comment-column: 50; -*-
;;;


(setq load-path (append '("~/.lisp") load-path))
(setq load-path (append '("~/.lisp/configs") load-path))

(load-library "install-packages-config")   ; Automatically install required
                                           ; packages on startup

(load-library "keys-config")                      ; All keys combinations,
                                                  ; keystrokes

(load-library "ux-config")                        ; Menues, views, tabs, font-lock

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))



(if (eq system-type "darwin")
    (set-input-method 'ucs)) ;; to make ^-S work on macOSX

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;;; MODES
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))

;;; Language modes

;(load-library "projectile")
(load-file "~/.lisp/configs/projectile.el")
(load-library "crystal-config")
(load-library "css-config")                       ; SASS,SCSS too
(load-library "docker-config")
(load-library "html-config")
(load-library "json-config")
(load-library "markdown-config")
(load-library "perl-config")
(load-library "python-config")
(load-library "ruby-config")
(load-library "rust-config")
(load-library "shell-config")
(load-library "systemd-config")                   ;SystemD, Fleet
(load-library "textile-config")
(load-library "yaml-config")
;; (load-library "cheetah-config") ; Cheetah-Mode is for editing snippets in Cobbler
;; (load-library "puppet-config")
;; (load-library "slim-config")



;; Missing from ruby-mode.el, see https://groups.google.com/group/emacs-on-rails/msg/565fba8263233c28
(defun ruby-insert-end ()
  "Insert \"end\" at point and reindent current line."
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

(add-hook 'ruby-mode-hook
          (lambda ()
            (require 'ruby-electric)
            (ruby-electric-mode t)))

;;; ----------------------------------------
;;; -- Ruby mode

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(column-number-mode t)
 '(line-number-mode 1)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))

(setq initial-scratch-message nil)


(require 'snippet)
;;; Server
(server-start)

;; (setq linum-format "%4d\u2502 ")
(global-hl-line-mode 1)
; (set-face-background hl-line-face "#E0FFE0")


;; other window - disable split
(setq split-width-threshold nil)
(setq split-height-threshold nil)
(put 'dired-find-alternate-file 'disabled nil)

;; Configs
;; (load-file "~/.lisp/configs/enh-ruby-config.el")
;; (load-file "~/.lisp/configs/autocomplete.el")
;(load-file "~/.lisp/configs/projectile.el")

(defun align-to-equals (begin end)
  "Align region to equal signs"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))
(global-set-key (kbd "C-c a =") 'align-to-equals)

(set-default-font "-apple-Inconsolata-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1")

;; http://stackoverflow.com/questions/2284703/emacs-how-to-disable-file-changed-on-disk-checking
(global-auto-revert-mode)

(set-variable 'vc-follow-symlinks' t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ;; Docker files

;; (require 'dockerfile-mode)
;; (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;; (add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))
