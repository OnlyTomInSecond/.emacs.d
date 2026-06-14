;; -*- lexical-binding: t -*-

(use-package corfu
  :defer 1
  :ensure t
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)          ;; TAB 循环下一个候选项
        ("S-TAB" . corfu-previous)    ;; S-TAB 循环上一个
        ("s-SPC" . corfu-insert-separator))
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-quit-at-boundary 'nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match 'separator)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect 'insert)      ;; Preselect the prompt
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches

  :init
  (global-corfu-mode)
  )

;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :defer 1
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  ;; Since 29.1, use `dabbrev-ignored-buffer-regexps' on older.
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

;; ======================================================================
;; eglot
;;Language Server (eglot - builtin since v29)
(use-package eglot
  :ensure t
  ;; 使用 prog-mode-hook，空闲 0.3 秒后再启动 eglot
  ;; 避免打开文件时立即触发 LSP 导致窗口切换
  :hook
  (prog-mode . (lambda ()
                 (unless (eq major-mode 'emacs-lisp-mode)
                   (eglot-ensure))))

  :config
  (setq eglot-server-programs
        (append '(
                  ((c-mode c-ts-mode c++-mode c++-ts-mode c-or-c++-mode c-or-c++-ts-mode)
                   . ("bash" "/home/whh/.emacs.d/bin/ccls.sh"))
                  ((python-mode python-ts-mode). ("bash" "/home/whh/.emacs.d/bin/ty.sh"))
                  )
				eglot-server-programs
				))
  ;; Eglot 性能优化
  (setq eglot-send-changes-idle-time 0.5        ;; 减少高频变更发送
        eglot-ignored-server-capabilities
        '(:documentOnTypeFormattingProvider     ;; 关闭输入时格式化
          :inlayHintProvider                    ;; 关闭 inline hints 提升渲染性能
          )))

;; Enable Code Folding
(use-package hideshow
  :ensure t
  :defer t
  :hook (prog-mode . hs-minor-mode)
  )


;; Code format ============================

(use-package treesit
  :ensure nil ;; Builtin in emacs 29
  :config
  (setq treesit-language-source-alist
        '((bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
          (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
          (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
          (cmake      . ("https://github.com/uyha/tree-sitter-cmake"))
          (elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
          (java       . ("https://github.com/tree-sitter/tree-sitter-java.git"))
          (make       . ("https://github.com/alemuller/tree-sitter-make"))
          (markdown   . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
          (org        . ("https://github.com/milisims/tree-sitter-org"))
          (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
          (rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
          )))

(use-package treesit-auto
  :ensure t
  :defer t
  :commands (global-treesit-auto-mode)
  :init
  (defvar my/treesit-auto-done nil)
  (defun my/enable-treesit-auto-once ()
    (when (and (derived-mode-p 'prog-mode)
               (not my/treesit-auto-done))
      (setq my/treesit-auto-done t)
      (global-treesit-auto-mode 1)))
  (add-hook 'prog-mode-hook #'my/enable-treesit-auto-once)
  :config
  (setq treesit-auto-langs '(c cpp cmake python elisp java rust))
  (setq c-ts-mode-indent-style 'linux)
  (setq c-ts-mode-indent-offset 4)
  (setq treesit-font-lock-level 4)
  (treesit-auto-add-to-auto-mode-alist 'all)
  :custom
  (treesit-auto-install 'prompt)
  )


;; Code format ============================
(use-package format-all
  :ensure t
  :defer t
  :config
  (setq-default format-all-formatters
                '(
                  ("C" (clang-format "--style=file:/home/whh/.emacs.d/configs/clang-format"))
                  ("C++" (clang-format "--style=file:/home/whh/.emacs.d/configs/clang-format"))
                  ("Python" (yapf "--style" "google"))
                  ("Shell" (shfmt "-i" "4" "-ci"))
                  ("Java" (astyle "--mode=java"))
                  ("CMake" (cmake-format))
                  ))
  :bind (
         ("C-M-\\" . format-all-region)
         ))

;; flymake shortcuts
(global-set-key (kbd "M-n") #'flymake-goto-next-error)
(global-set-key (kbd "M-p") #'flymake-goto-prev-error)

(provide 'init_lsp)
