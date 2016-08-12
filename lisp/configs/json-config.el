(require 'json-mode)
(autoload 'json-mode "json-mode" "Major mode for editing JSON data")
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
