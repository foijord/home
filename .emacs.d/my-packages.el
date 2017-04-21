
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar required-packages '(flycheck yaml-mode js2-mode json-mode web-mode) "a list of packages installed at launch.")

(require 'cl)
;; check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

;; install any missing packages
(unless (packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))
