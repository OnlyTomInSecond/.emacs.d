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
  (markdown-fontify-code-blocks-natively t)
  (markdown-command '("pandoc" "--from=markdown" "--to=html5"))
  )

;; 长行优化：对于超长行的文件自动启用 so-long-mode
(use-package so-long
  :ensure nil  ;; built-in since Emacs 27
  :defer t
  :hook (after-init . global-so-long-mode)
  :custom
  (so-long-target-modes '(prog-mode org-mode markdown-mode text-mode))
  (so-long-threshold 500)
  (so-long-max-lines 100))

(provide 'init_text)
