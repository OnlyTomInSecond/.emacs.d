;; -*- lexical-binding: t -*-

(use-package magit
  :ensure t
  :defer t
  :bind ("C-x g" . magit-status)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :config
  ;; 关闭一些可能拖慢速度的可选功能
  (setq magit-refresh-status-buffer nil
        magit-section-visibility-indicator nil))

(provide 'init_tools)
