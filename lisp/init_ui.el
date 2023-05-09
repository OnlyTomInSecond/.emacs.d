;; Use default theme in terminals
(use-package doom-themes
  :ensure t
  :when (display-graphic-p)
  :config
  (load-theme 'doom-one t)
  (set-frame-font "Monospace 12" nil t)
  (doom-themes-org-config))

(use-package emacs
  :ensure nil
  :unless (display-graphic-p)
  :config
  (load-theme 'tango-dark t)
  )

(use-package help
  :ensure nil
  :hook (after-init . temp-buffer-resize-mode)
  :custom
  (help-window-select t))

;;============================
(provide 'init_ui)
