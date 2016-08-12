
;;; ==================================================================
;;;  Install required packages
;;;
(defvar prelude-packages

  '(coffee-mode gist haml-mode inf-ruby markdown-mode ruby-mode smartparens
                rhtml-mode ruby-electric rinari flymake-ruby json-mode
                textile-mode projectile projectile-rails python sass-mode
                rainbow-mode scss-mode sass-mode css-mode slim-mode
                color-theme volatile-highlights yaml-mode yari snippet
                systemd pabbrev ag enh-ruby-mode autopair flex-autopair
                magit exec-path-from-shell auto-complete )

  "A list of packages to ensure are installed at launch.")
;; --------------------------------------------

(require 'cl)                                     ;for loop macro
(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;
(defun prelude-packages-installed-p ()
 (loop for p in prelude-packages
       when (not (package-installed-p p)) do (return nil)
       finally (return t)))
;
(unless (prelude-packages-installed-p)
 ;; check for new packages (package versions)
 (message "%s" "Emacs Prelude is now refreshing its package database...")
 (package-refresh-contents)
 (message "%s" " done.")
 ;; install the missing packages
 (dolist (p prelude-packages)
   (when (not (package-installed-p p))
     (package-install p))))

(provide 'prelude-packages)
;;;                                                                                       ==================================================================
;;; prelude-packages.el ends here
