;;;
;;; PERL
;;;

;(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq cperl-hairy t)
(setq auto-mode-alist (append '(("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode))  auto-mode-alist ))
(setq interpreter-mode-alist (append interpreter-mode-alist '(("miniperl" . cperl-mode))))
(setq perl-tab-to-comment 't)
(setq exec-path (append '("/usr/local/bin") exec-path))
