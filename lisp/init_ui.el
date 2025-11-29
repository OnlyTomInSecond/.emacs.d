;; -*- lexical-binding: t -*-

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "Monospace" :foundry "ADBO" :slant normal :weight normal :height 113 :width normal)))))
;; ;; (load-theme 'tango-dark t)

;; (use-package doom-themes
;;   :ensure t
;;   :defer 0.5
;;   :config
;;   (load-theme 'doom-one t)
;;   :custom
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled

;;   ;; Enable flashing mode-line on errors
;;   ;; (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   ;; (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   ;; (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   ;; (doom-themes-org-config)
;;   )

(use-package gruber-darker-theme
  :ensure t
;;  :defer 0.5
  :config
  (setq custom-file "~/.emacs.d/custom.el")
  (load custom-file)
  (set-frame-font (font-spec :family "Monospace" :size 16))
  )

;;============================
(provide 'init_ui)
