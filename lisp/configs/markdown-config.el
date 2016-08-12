;;;
;;; Markdown mode
;;;
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

(defun markdown-custom () "markdown-mode-hook"
       (set-variable 'fill-column' 72)
       (setq tab-width 2)
       (local-set-key [M-right] 'forward-word)
       (local-set-key [M-left] 'backward-word)
  )

(add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))
