;; Set the window size
(add-to-list 'default-frame-alist '(width . 132))
(add-to-list 'default-frame-alist '(height . 42))


;; Use default theme in terminals
(use-package doom-themes
  :ensure t
  :when (display-graphic-p)
  :config
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package emacs
  :ensure nil
  :unless (display-graphic-p)
  :config
  (load-theme 'leuven t))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-irc nil)
  (doom-modeline-mu4e nil)
  (doom-modeline-gnus nil)
  (doom-modeline-github nil)
  (doom-modeline-persp-name nil)
  (doom-modeline-unicode-fallback t)
  (doom-modeline-enable-word-count nil))

(use-package help
  :ensure nil
  :hook (after-init . temp-buffer-resize-mode)
  :custom
  (help-window-select t))


;;============================
(provide 'init_ui)
