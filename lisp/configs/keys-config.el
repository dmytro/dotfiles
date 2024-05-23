;;; 2009/03/30
;;; http://groups.google.com/group/carbon-emacs/browse_thread/thread/537c1d730453c94f?pli =1
(setq mac-command-modifier 'meta)

;;; Navigating with M-up/down - previos window
;;; http://nex-3.com/posts/45-efficient-window-switching-in-emacs

(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-`") 'select-next-window)
(global-set-key (kbd "M-<up>") 'select-next-window)
(global-set-key (kbd "M-<down>")  'select-previous-window)

(global-set-key [C-left] 'windmove-left)          ; move to left windnow
(global-set-key [C-right] 'windmove-right)        ; move to right window
(global-set-key (kbd "M-[") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "M-]") 'windmove-right)        ; move to right window
(global-set-key [C-up] 'windmove-up)              ; move to upper window
(global-set-key [C-down] 'windmove-down)          ; move to downer window

;;; These are defaults anyway
(global-set-key [M-right] 'forward-word)
(global-set-key [M-left]  'backward-word)

;;; Full screen mode on/off
;; (local-set-key (kbd "M-RET") 'toggle-frame-maximized)
;; (global-set-key (kbd "M-RET") 'toggle-fullscreen)
(local-set-key (kbd "M-RET") 'toggle-frame-maximized)
(global-set-key (kbd "M-RET") 'toggle-frame-maximized)

;; In X Window C-z and C-xC-z are bound to ncofng wndo whch s dsturbnng for me
;;iconify-or-deiconify-frame
(global-unset-key "\C-z")
(local-unset-key "\C-z")
(global-unset-key "\C-x\C-z")
(local-unset-key "\C-x\C-z")

;;; undo to C-x C-u
(local-set-key "\C-x\C-u" 'advertised-undo)
(global-set-key "\C-x\C-u" 'advertised-undo)
(global-set-key "\M-_" 'advertised-undo) ; Meta-_
(global-set-key "\M-z" 'advertised-undo) ; Meta-z

					;  other window -> C-x C-o (instead of C-x o)
(local-set-key "\C-x\C-o" 'other-window)
(global-set-key "\C-x\C-o" 'other-window)

;;;
;;; KEYS
;;;
(global-set-key "\C-g" 'goto-line)
(local-set-key "\C-g" 'goto-line)
(local-set-key "\C-x\C-o" 'other-window)
(global-set-key "\C-x\C-o" 'other-window)
(global-set-key "\M-`" 'other-window)

(global-set-key "\C-x\C-b" 'buffer-menu) ; Open buffer list in the same buffer, intead of other

;; http://stackoverflow.com/questions/11623189/how-to-bind-keys-to-indent-unindent-region-in-emacs/11624677#11624677
;;
(require 'smartparens-config)
(defun my-indent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 2))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -2))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(sp-pair "<" nil :actions :rem)
(sp-pair ">" nil :actions :rem)
(global-set-key ">" 'my-indent-region)
(global-set-key "<" 'my-unindent-region)

(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key (kbd "C-%") 'goto-match-paren)
