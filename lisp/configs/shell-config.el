;;
;; SHELL
;;
(if (file-exists-p "/bin/bash") (setq explicit-shell-file-name "/bin/bash"))
(if (file-exists-p "/bin/zsh")  (setq explicit-shell-file-name "/bin/zsh"))

(defun setup-sh-mode ()
  "Personal preferences for `sh-mode'."
  (interactive)
  (setq sh-basic-offset 2
        sh-indentation 2))

(add-hook 'sh-mode-hook 'setup-sh-mode)
