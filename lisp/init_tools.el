;; -*- lexical-binding: t -*-

(use-package projectile
  :ensure t
  :defer t
  :bind-keymap ("C-c p" . projectile-command-map)
  :hook (after-init . projectile-mode)
  :custom
  (projectile-completion-system 'auto)
  (projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))
  ;; (projectile-project-search-path '("~/projects" "~/dev"))
  )
  ;; 根据实际情况修改上面的搜索路径

(use-package magit
  :ensure t
  :defer t
  :bind ("C-x g" . magit-status)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :config
  (setq magit-refresh-status-buffer nil
        magit-section-visibility-indicator nil))

(provide 'init_tools)
