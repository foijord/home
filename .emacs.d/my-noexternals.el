;; Don't give me that welcome screen
(setq inhibit-startup-message t)

;; Remove scrollbars, menu bars and toolbars
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Don't make backup files at all
(setq make-backup-files nil)

;; Reload changed files
(global-auto-revert-mode t)

;; Global keybindings
(global-set-key "\M-j" 'goto-line)

;; Ignore case for filename completion
(setq isearch-case-fold-search t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(defun code-mode()
  (interactive)
  (setq truncate-lines t)
  (setq js-indent-level 2)
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil))

(add-hook 'c-mode-hook 'code-mode)
(add-hook 'c++-mode-hook 'code-mode)
(add-hook 'glsl-mode-hook 'code-mode)
(add-hook 'python-mode-hook 'code-mode)
(add-hook 'java-mode-hook 'code-mode)
(add-hook 'glsl-mode-hook 'code-mode)
(add-hook 'js-mode-hook 'code-mode)
(add-hook 'html-mode-hook 'code-mode)
(add-hook 'lua-mode-hook 'code-mode)

(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . c++-mode))
