;; Use default theme in terminals
(use-package doom-themes
  :ensure t
  :when (display-graphic-p)
  :config
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package emacs
  :ensure nil
  :config
  (setq display-line-numbers-type 't)
  (global-display-line-numbers-mode t)
  )

(use-package help
  :ensure nil
  :hook (after-init . temp-buffer-resize-mode)
  :custom
  (help-window-select t))

;;============================
(provide 'init_ui)
