;; -*- mode: Lisp; fill-column: 75; comment-column: 50; -*-
;;;

(setq load-path (append '("~/.lisp") load-path))
(setq load-path (append '("~/.lisp/configs") load-path))

(load-library "install-packages-config")   ; Automatically install required
                                           ; packages on startup

(load-library "keys-config")                      ; All keys combinations,
                                                  ; keystrokes

(load-library "ux-config")                        ; Menues, views, tabs, font-lock, colors

(load-library "autosaves-config")

(load-library "locale-config")

(load-library "window-size-config")

;;;; MODES
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))

;;; Language modes

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
(load-library "groovy-config")
;; (load-library "cheetah-config") ; Cheetah-Mode is for editing snippets in Cobbler
;; (load-library "puppet-config")
;; (load-library "slim-config")


;;  For some reason load-library does not work for projectile... --dk
(load-file "~/.lisp/configs/projectile.el")


;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CUSTOM
;;  Generated stuff

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(enh-ruby-op-face ((t (:foreground "selectedControlColor"))))
 '(font-lock-comment-face ((t (:foreground "controlShadowColor" :slant italic)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(column-number-mode t)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil))
