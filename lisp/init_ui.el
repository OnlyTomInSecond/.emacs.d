;; Use default theme in terminals
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
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
