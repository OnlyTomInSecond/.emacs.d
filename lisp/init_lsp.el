(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :bind (
         :map company-mode-map
         ([remap completion-at-point] . company-complete)
         :map company-active-map
         ("C-s"     . company-filter-candidates)
         ([tab]     . company-complete-common-or-cycle)
         ([backtab] . company-select-previous-or-abort))
  
  :custom
  (company-idle-delay 0)
  ;; Easy navigation to candidates with M-<n>
  (company-show-quick-access t)
  (company-require-match nil)
  (company-minimum-prefix-length 2)
  (company-tooltip-width-grow-only t)
  (company-tooltip-align-annotations t)
  ;; complete `abbrev' only in current buffer and make dabbrev case-sensitive
  (company-dabbrev-other-buffers nil)
  (company-dabbrev-ignore-case nil)
  (company-dabbrev-downcase nil)
  ;; make dabbrev-code case-sensitive
  (company-dabbrev-code-ignore-case nil)
  (company-dabbrev-code-everywhere t)
  ;; call `tempo-expand-if-complete' after completion
  (company-tempo-expand t)
  ;; Ignore uninteresting files. Items end with a slash are recognized as
  ;; directories.
  (company-files-exclusions '(".git/" ".DS_Store"))
  ;; No icons
  (company-format-margin-function nil)
;;  (company-backends '((company-capf :with company-tempo)
;;                      company-files
;;                      (company-dabbrev-code company-keywords)
;;                      company-dabbrev)
;;                    company-dict
;;                    company-c-headers
;;                    )
  )

;; lsp-mode
(use-package lsp-mode
  :ensure t
  :hook (
         (c-mode . lsp)
         (c++-mode . lsp)
         (java-mode . lsp)
         )

  :custom
  (lsp-enable-links nil)                 ;; no clickable links
  (lsp-enable-folding nil)               ;; use `hideshow' instead
  (lsp-enable-snippet t)                 ;; no snippets, it requires `yasnippet'
  (lsp-enable-file-watchers nil)         ;; performance matters
  (lsp-enable-text-document-color nil)   ;; as above
  (lsp-enable-symbol-highlighting nil)   ;; as above
  (lsp-enable-on-type-formatting nil)    ;; as above
  (lsp-enable-indentation nil)           ;; don't change my code without my permission
  (lsp-headerline-breadcrumb-enable nil) ;; keep headline clean
  (lsp-modeline-code-actions-enable nil) ;; keep modeline clean
  (lsp-modeline-diagnostics-enable nil)  ;; as above
  (lsp-log-io nil)                       ;; debug only
  (lsp-auto-guess-root t)                ;; Yes, I'm using projectile
  (lsp-completion-provider :none)        ;; don't add `company-capf' to `company-backends'
  (lsp-keep-workspace-alive nil)         ;; auto kill lsp server
  (lsp-eldoc-enable-hover nil))          ;; disable eldoc hover

(use-package cc-mode
  :ensure t
  :config
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "linux"))
        )
  (setq c-basic-offset 4)
  )
(use-package lsp-java
  :ensure t
  :hook (java-mode . lsp)
  :custom
  (lsp-java-completion-enabled t)
  )

(use-package clang-format
  :ensure t
  :bind (
         ("C-c f b" . clang-format-buffer)
         )
  :custom
  (clang-format-style "{BasedOnStyle: llvm, IndentWidth: 4}")
  (clang-format-fallback-style "gnu")
  )

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :hook (prog-mode . company-mode))

(use-package yasnippet
  :ensure t
  :hook (prog-mode . yas-minor-mode)
  )
(use-package yasnippet-snippets :ensure t)


(use-package company-dict
  :ensure t
  :config
  (add-to-list 'company-backends 'company-dict)
  )

(use-package company-c-headers
  :ensure t
  :config
  (add-to-list 'company-backends 'company-c-headers)
  )

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

;;(setq four-tab-gnu '("four-tab-gnu"
;;                     "gnu"
;;                     (indent-tabs-mode . nil)
;;                     (c-basic-offset . 4)
;;                     ))
;;(add-to-list 'c-default-style '(c++-mode . "four-tab-gnu"))
;;(add-to-list 'c-default-style '(c-mode . "four-tab-gnu"))
;;(add-to-list 'c-default-style '(markdown-mode . "my-style"))

(setenv "JAVA_HOME" "/usr/lib/jvm/java-20-openjdk/")

(provide 'init_lsp)
