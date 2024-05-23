;; -*- lexical-binding: t -*-

;; Pixel alignment for org/markdown tables
(use-package valign
  :ensure t
  :defer 1
  :hook ((markdown-mode org-mode) . valign-mode))

;; The markdown mode
(use-package markdown-mode
  :ensure t
  :defer 1
  :mode ("README\\(?:\\.md\\)?\\'" . gfm-mode)
  :hook (markdown-mode . visual-line-mode)

  :custom
  (markdown-header-scaling t)
  (markdown-enable-wiki-links t)
  (markdown-italic-underscore t)
  (markdown-asymmetric-header t)
  (markdown-gfm-uppercase-checkbox t)
  (markdown-fontify-code-blocks-natively t))

;; ReStructuredText
(use-package rst
  :ensure nil
  :hook ((rst-mode . visual-line-mode)
         (rst-adjust . rst-toc-update)))

(use-package rime
  :ensure t
  ;;:defer t
  :commands (rime-mode)
  :bind
  (:map rime-mode-map
        ("C-`" . 'rime-send-keybinding))
  :config
  ;;On arch Linux, rime will crash when emacs exits, see https://github.com/DogLooksGood/emacs-rime/issues/161
  (setq rime-enabled-once 't);;Whether rime actived once or not?
  (add-hook 'kill-emacs-hook
            (lambda ()
              (when rime-enabled-once (rime-lib-finalize)))
            )
  (setq rime-share-data-dir "~/.local/share/fcitx5/rime_emacs/")
  (setq rime-user-data-dir "~/.local/share/fcitx5/rime_emacs/")
  :custom
  (default-input-method 'rime)
  (rime-show-candidate 'popup)
  )

(provide 'init_text)
