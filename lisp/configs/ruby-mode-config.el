(defun ruby-eval-buffer () (interactive)
    "Evaluate the buffer with ruby."
    (shell-command-on-region (point-min) (point-max) "ruby"))


(defun my-ruby-mode-hook ()
  (setq standard-indent 4)
  (pabbrev-mode t)
  (ruby-electric-mode t)
  (define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer)
  (delete-selection-mode t)
  )
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$"   . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$"   . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$"   . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$"   . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile"  . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile"  . ruby-mode))
(add-to-list 'auto-mode-alist '("Cheffile"  . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile"  . ruby-mode))
(add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))

(defadvice ruby-indent-line (after line-up-args activate)
  (let (indent prev-indent arg-indent)
    (save-excursion
      (back-to-indentation)
      (when (zerop (car (syntax-ppss)))
        (setq indent (current-column))
        (skip-chars-backward " \t\n")
        (when (eq ?, (char-before))
          (ruby-backward-sexp)
          (back-to-indentation)
          (setq prev-indent (current-column))
          (skip-syntax-forward "w_.")
          (skip-chars-forward " ")
          (setq arg-indent (current-column)))))
    (when prev-indent
      (let ((offset (- (current-column) indent)))
        (cond ((< indent prev-indent)
               (indent-line-to prev-indent))
              ((= indent prev-indent)
               (indent-line-to arg-indent)))
        (when (> offset 0) (forward-char offset))))))

(setq ruby-deep-indent-paren nil)

(require 'flymake-ruby)                 ; Syntax checker for Ruby
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
