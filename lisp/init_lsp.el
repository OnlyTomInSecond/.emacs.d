(use-package company
  :ensure t
  :config (global-company-mode)
  :bind (
         ;; :map company-mode-map
         ;;([remap completion-at-point] . company-complete)
         :map company-active-map
         ;;("C-s"     . company-filter-candidates)
         ([tab]     . company-complete-common-or-cycle)
         ([backtab] . company-select-previous-or-abort))

  :custom
  (company-backends '(company-bbdb company-semantic company-cmake company-capf company-files
              (company-dabbrev-code company-etags company-keywords)
              company-oddmuse company-dabbrev))
  (company-idle-delay 0.0)
  ;; Easy navigation to candidates with M-<n>
  (company-show-quick-access t)
  (company-require-match nil)
  (company-minimum-prefix-length 3)
  (company-tooltip-width-grow-only t)
  (company-tooltip-align-annotations t)
  ;; complete `abbrev' only in current buffer and make dabbrev case-sensitive
  ;;(company-dabbrev-other-buffers nil)
  ;;(company-dabbrev-ignore-case nil)
  ;;(company-dabbrev-downcase nil)
  ;; make dabbrev-code not case-sensitive
  (company-dabbrev-code-ignore-case t)
  (company-dabbrev-code-everywhere t)
  ;; call `tempo-expand-if-complete' after completion
  ;;(company-tempo-expand t)
  ;; Ignore uninteresting files. Items end with a slash are recognized as
  ;; directories.
  (company-files-exclusions '(".git/" ".DS_Store"))
  ;; No icons
  (company-format-margin-function nil)
  )

(use-package company-c-headers
  :ensure t
  :after (company)
  :hook (((c-mode c++-mode) . (lambda ()
                               (add-to-list 'company-backends 'company-c-headers t)))
         (c++-mode . (lambda ()
                       (add-to-list 'company-c-headers-path-system "/usr/include/c++/13.2.1/")))
         )
  )

(use-package company-elisp
  :after (company)
  )

;; Add `company-elisp' backend for elisp.
;;(add-hook 'emacs-lisp-mode-hook
;;          #'(lambda ()
;;              (require 'company-elisp)
;;              (push 'company-elisp company-backends)))

;; lsp-mode
(use-package lsp-mode
  :ensure t
  :config
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode)
         (c++-mode)
         ;; (java-mode)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp

  :custom
  (lsp-enable-links nil)                    ;; no clickable links
  (lsp-enable-folding nil)                  ;; use `hideshow' instead
  (lsp-enable-snippet nil)                  ;; no snippets, it requires `yasnippet'
  (lsp-enable-file-watchers nil)            ;; performance matters
  (lsp-enable-text-document-color nil)      ;; as above
  (lsp-enable-symbol-highlighting nil)      ;; as above
  (lsp-enable-on-type-formatting nil)       ;; as above
  (lsp-enable-indentation nil)              ;; don't change my code without my permission
  (lsp-headerline-breadcrumb-enable nil)    ;; keep headline clean
  (lsp-modeline-code-actions-enable nil)    ;; keep modeline clean
  (lsp-modeline-diagnostics-enable nil)     ;; as above
  (lsp-log-io nil)                          ;; debug only
  ;;(lsp-auto-guess-root t)                 ;; Yes, I'm using projectile
  (lsp-completion-provider :none)           ;; don't add `company-capf' to `company-backends'
  (lsp-keep-workspace-alive nil)            ;; auto kill lsp server
  (lsp-eldoc-enable-hover nil)              ;; disable eldoc hover
  (lsp-lens-enable nil)                     ;; disable lenses
  )

;; optionally
(use-package lsp-ui
  :ensure t
  :custom
  (lsp-ui-doc-enable nil)                   ;;disable lsp-ui-doc
  (lsp-ui-sideline-enable nil)              ;;disable sideline
  (lsp-ui-sideline-show-hover nil)          ;;don't show hover messages in sideline
  )

;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language


;;(use-package lsp-java
;;  :ensure t
;;  :hook (java-mode . lsp)
;;  :custom
;;  (lsp-java-completion-enabled t)
;;  )

;; ccls
(use-package ccls
  ;;:ensure t
  :hook ((c-mode c++-mode) .
         (lambda () (lsp)))

  :custom
  (ccls-executable "/usr/bin/ccls")
  (ccls-initialization-options
   '(:index (:comments 2) :completion (:detailedLabel t)))
  )

(use-package cc-mode
  ;;:ensure t
  :config
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "linux"))
        )
  (setq c-basic-offset 4)
  )
(use-package clang-format
  ;;:ensure t
  :bind (
         ("C-c f b" . clang-format-buffer)
         )
  :custom
  (clang-format-style "{BasedOnStyle: llvm, IndentWidth: 4}")
  (clang-format-fallback-style "gnu")
  )

(use-package flycheck
  :ensure t
  :after (company)
  :hook (prog-mode . flycheck-mode)
  )

(use-package yasnippet
  :ensure t
  :after (company)
  :hook (prog-mode . yas-minor-mode)
  )

(use-package yasnippet-snippets
  :ensure t
  )


(use-package company-dict
  :ensure t
  )

(use-package projectile
  :ensure t
  :init
  (projectile-mode 1)
  :bind (:map projectile-mode-map
              ;;("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

;;(setenv "JAVA_HOME" "/usr/lib/jvm/java-20-openjdk/")

(provide 'init_lsp)
;;; init_lsp.el ends here
