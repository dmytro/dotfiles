(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(setq-default puppet-indent-level 4)
(setq-default puppet-indent-tabs-mode nil)
