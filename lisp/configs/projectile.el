;; Projectile

(setq projectile-rails-keymap-prefix (kbd "M-r"))
(setq projectile-keymap-prefix (kbd "C-c C-p"))
(projectile-global-mode)
;; (add-hook 'ruby-mode-hook 'projectile-on)
;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "Down") 'ido-next-match)
    (define-key ido-completion-map (kbd "Up") 'ido-prev-match)
    )
(add-hook 'ido-setup-hook 'ido-define-keys)

(global-set-key (kbd "C-x C-d") 'projectile-dired)

(add-hook 'projectile-mode-hook 'projectile-rails-on)

;;  IDO mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-file-extensions-order '(".rb" ".erb" ".yml" ))

;(setq projectile-keymap-prefix (kbd "C-p"))
