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
  :config
  (define-advice company-capf--candidates (:around (func &rest args))
    "Try default completion styles."
    (let ((completion-styles '(basic partial-completion)))
      (apply func args)))
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
  (company-backends '((company-capf :with company-tempo)
                      company-files
                      (company-dabbrev-code company-keywords)
                      company-dabbrev
                      ;; HACK: prevent `lsp-mode' to add `company-capf' back.
                      company-capf)))

;; lsp-mode
(use-package lsp-mode
  :ensure t
  :hook (
         (lsp-mode . lsp-enable-which-key-integration)
         (c-mode . lsp)
         (c++-mode . lsp)
         (java-mode . lsp)
         )
  :bind (:map lsp-mode-map
              ("C-c f r" . lsp-format-region)
		      ("C-c f b" . lsp-format-buffer)
              ("C-c d" . lsp-describe-thing-at-point)
              ("C-c a" . lsp-execute-code-action)
              ("C-c r" . lsp-rename))
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-enable-links nil)                 ;; no clickable links
  (lsp-enable-folding nil)               ;; use `hideshow' instead
  (lsp-enable-snippet nil)               ;; no snippets, it requires `yasnippet'
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
  (lsp-keep-workspace-alive nil)         ;; auto kill lsp server
  (lsp-eldoc-enable-hover nil))          ;; disable eldoc hover

(use-package cc-mode
  :init
  (define-key c-mode-map  [(tab)] 'company-complete)
  (define-key c++-mode-map  [(tab)] 'company-complete))

(use-package lsp-java 
  :ensure t
  :config (add-hook 'java-mode-hook 'lsp)
  :custom
  (lsp-java-completion-enabled t)
  )

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :hook (prog-mode . company-mode))

(use-package yasnippet :config (yas-global-mode))
(use-package yasnippet-snippets :ensure t)


(use-package company-dict
  :ensure t
  :init
  (add-to-list 'company-backends 'company-dict))

(use-package company-c-headers
  :ensure t
  :init
  (add-to-list 'company-backends 'company-c-headers))

(setq four-tab-gnu '("four-tab-gnu"
                     "gnu"
                     (indent-tabs-mode . nil)
                     (c-basic-offset . 4)
                     ))
(add-to-list 'c-default-style '(c++-mode . "four-tab-gnu"))
(add-to-list 'c-default-style '(c-mode . "four-tab-gnu"))
(add-to-list 'c-default-style '(markdown-mode . "my-style"))

(setenv "JAVA_HOME" "/usr/lib/jvm/java-19-openjdk/")

(provide 'init_lsp)


