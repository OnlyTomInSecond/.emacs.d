;; -*- lexical-binding: t -*-

;; 使用 vertico + orderless + consult

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico-count 16)
  (vertico-resize t)
  :config
  (setq vertico-buffer-display-delay 0.1))

(use-package savehist
  :ensure t
  :hook (after-init . savehist-mode)
  :custom
  (savehist-autosave-interval 300)
  (savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
  )

(use-package orderless
  :ensure t
  :defer 0.5
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  )

(use-package consult
  :ensure t
  :defer 1
  :bind (("C-x b" . consult-buffer))
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   :preview-key '(:debounce 0.4 any)))

(provide 'init_ivy)
