;;; configuration for company mode and lsp
(use-package company
  :ensure t
  :config (global-company-mode)
  :bind (
         ;; :map company-mode-map
         ;;([remap completion-at-point] . company-complete)
         :map company-active-map
         ("C-s"     . company-filter-candidates)
         ([tab]     . company-complete-common-or-cycle)
         ([backtab] . company-select-previous-or-abort))

  :custom
  ;; (company-backends '(company-capf company-bbdb company-semantic
  ;;                                  company-cmake company-files
  ;;                                  (company-dabbrev-code company-etags company-keywords)
  ;;                                  company-oddmuse company-dabbrev)
  ;;                   )
  (company-idle-delay 0.0)
  ;; Easy navigation to candidates with M-<n>
  (company-show-quick-access t)
  (company-require-match nil)
  (company-minimum-prefix-length 3)
  (company-selection-wrap-around t)
  ;;(company-tooltip-width-grow-only t)
  (company-tooltip-align-annotations t)
  ;; complete `abbrev' only in current buffer and make dabbrev case-sensitive
  (company-dabbrev-other-buffers t)
  (company-dabbrev-ignore-case nil)
  (company-dabbrev-downcase nil)
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
                       (add-to-list 'company-c-headers-path-system "/usr/include/c++/13.2.1/")
                       ;; For termux
                       ;; (add-to-list 'company-c-headers-path-system "~/../usr/include/c++/v1/")
                       ))
         )
  )
;; ==============================================================================
;; lsp-mode
;; (use-package lsp-mode
;;   :ensure t
;;   :config
;;   ;; set lsp-mode keymap
;;   (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
;;
;;   :hook (
;;          ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (c-mode)
;;          (c++-mode)
;;          (python-mode)
;;          (cmake-mode)
;;          ;; (java-mode)
;;          ;; if you want which-key integration
;;          ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;          (lsp-mode . lsp-enable-which-key-integration)
;;          )
;;   :commands lsp
;;
;;   :custom
;;   (lsp-enable-links nil)                    ;; no clickable links
;;   (lsp-enable-folding nil)                  ;; use `hideshow' instead
;;   ;;(lsp-enable-snippet nil)                  ;; no snippets, it requires `yasnippet'
;;   (lsp-enable-file-watchers nil)            ;; performance matters
;;   (lsp-enable-text-document-color nil)      ;; as above
;;   (lsp-enable-symbol-highlighting nil)      ;; as above
;;   (lsp-enable-on-type-formatting nil)       ;; as above
;;   ;;(lsp-enable-indentation nil)              ;; don't change my code without my permission
;;   (lsp-headerline-breadcrumb-enable nil)    ;; keep headline clean
;;   (lsp-modeline-code-actions-enable nil)    ;; keep modeline clean
;;   (lsp-modeline-diagnostics-enable nil)     ;; as above
;;   (lsp-log-io nil)                          ;; debug only
;;   (lsp-auto-guess-root t)                 ;; Yes, I'm using projectile
;;   (lsp-completion-provider :none)           ;; don't add `company-capf' to `company-backends'
;;   (lsp-keep-workspace-alive nil)            ;; auto kill lsp server
;;   (lsp-eldoc-enable-hover nil)              ;; disable eldoc hover
;;   (lsp-lens-enable nil)                     ;; disable lenses
;;   )
;;
;; ;; optionally
;; (use-package lsp-ui
;;   :ensure t
;;   :custom
;;   (lsp-ui-doc-enable nil)                   ;;disable lsp-ui-doc
;;   (lsp-ui-sideline-enable nil)              ;;disable sideline
;;   (lsp-ui-sideline-show-hover nil)          ;;don't show hover messages in sideline
;;   )
;;
;; ;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; ======================================================================

;; eglot
;; Language Server (eglot - builtin since v29)
(use-package eglot
  ;;:bind ("C-c e f" . eglot-format)
  :init
  (add-hook 'prog-mode-hook
	        (lambda () (unless (member major-mode '(emacs-lisp-mode))
			             (eglot-ensure))))

  :config
  (add-to-list 'eglot-server-programs
               '((c-mode c-ts-mode c++-mode c++-ts-mode c-or-c++-mode c-or-c++-ts-mode)
                 . ("~/.emacs.d/bin/ccls.sh"))
               )
  )

;; ts-mode
;; (use-package treesit
;;   :when (and (fboundp 'treesit-available-p) (treesit-available-p))
;;   ;;:mode (("\\(?:Dockerfile\\(?:\\..*\\)?\\|\\.[Dd]ockerfile\\)\\'" . dockerfile-ts-mode)
;;   ;;("\\.go\\'" . go-ts-mode)
;;   ;;("/go\\.mod\\'" . go-mod-ts-mode)
;;   ;;("\\.rs\\'" . rust-ts-mode)
;;   ;;("\\.ts\\'" . typescript-ts-mode)
;;   ;;("\\.y[a]?ml\\'" . yaml-ts-mode))
;;   :config (setq treesit-font-lock-level 4)
;;   :init
;;   (setq major-mode-remap-alist
;;         '(
;;           (sh-mode . bash-ts-mode)
;;           (c-mode . c-ts-mode)
;;           (c++-mode . c++-ts-mode)
;;           (c-or-c++-mode . c-or-c++-ts-mode)
;;           ;;(css-mode . css-ts-mode)
;;           ;;(js-mode . js-ts-mode)
;;           (java-mode . java-ts-mode)
;;           ;;(js-json-mode . json-ts-mode)
;;           (makefile-mode . cmake-ts-mode)
;;           (python-mode . python-ts-mode)
;;           ;;(ruby-mode . ruby-ts-mode)
;;           ;;(conf-toml-mode . toml-ts-mode)
;;           (elisp-mode . elisp-ts-mode)
;;           (cmake-mode . cmake-ts-mode)
;;           ))
;;   (setq treesit-language-source-alist
;;         '((bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
;;           (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
;;           (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
;;           ;;(css        . ("https://github.com/tree-sitter/tree-sitter-css"))
;;           (cmake      . ("https://github.com/uyha/tree-sitter-cmake"))
;;           ;;(csharp     . ("https://github.com/tree-sitter/tree-sitter-c-sharp.git"))
;;           ;;(dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
;;           (elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
;;           ;;(go         . ("https://github.com/tree-sitter/tree-sitter-go"))
;;           ;;(gomod      . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))
;;           ;;(html       . ("https://github.com/tree-sitter/tree-sitter-html"))
;;           (java       . ("https://github.com/tree-sitter/tree-sitter-java.git"))
;;           ;;(javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
;;           ;;(json       . ("https://github.com/tree-sitter/tree-sitter-json"))
;;           ;;(lua        . ("https://github.com/Azganoth/tree-sitter-lua"))
;;           (make       . ("https://github.com/alemuller/tree-sitter-make"))
;;           (markdown   . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
;;           ;;(ocaml      . ("https://github.com/tree-sitter/tree-sitter-ocaml" nil "ocaml/src"))
;;           (org        . ("https://github.com/milisims/tree-sitter-org"))
;;           (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
;;           ;;(php        . ("https://github.com/tree-sitter/tree-sitter-php"))
;;           ;;(typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
;;           ;;(tsx        . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
;;           ;;(ruby       . ("https://github.com/tree-sitter/tree-sitter-ruby"))
;;           ;;(rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
;;           ;;(sql        . ("https://github.com/m-novikov/tree-sitter-sql"))
;;           ;;(vue        . ("https://github.com/merico-dev/tree-sitter-vue"))
;;           ;;(yaml       . ("https://github.com/ikatyang/tree-sitter-yaml"))
;;           ;;(toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))
;;           ;;(zig        . ("https://github.com/GrayJack/tree-sitter-zig"))
;;           ))
;;   )

;; ccls
;;(use-package ccls
;;  :ensure t
;;
;;  :custom
;;  (ccls-executable "~/.emacs.d/bin/ccls.sh")
;;  )

(use-package cc-mode
  ;;:ensure t
  :config
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "linux"))
        )
  (setq c-basic-offset 4)
  )

;; (use-package cmake-mode
;;   :ensure t
;;   )

;; Code format ============================
;; This needs clang-format,yapf(python),shfmt,astyle installed
(use-package format-all
  :ensure t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(
                  ("C" (clang-format "--style={BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4}"))
                  ("C++" (clang-format "--style={BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4}"))
                  ("Python" (yapf "--style" "google"))
                  ("Shell" (shfmt "-i" "4" "-ci"))
                  ("Java" (astyle "--mode=java"))
                  )
                )
  :bind (
         ("C-M-\\" . format-all-buffer)
         )
  )

;; (use-package flycheck
;;   :ensure t
;;   :after (company)
;;   :hook (prog-mode . flycheck-mode)
;;   )

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
              ("C-c p" . projectile-command-map))
  :custom
  (projectile-completion-system 'ivy)
  )
(provide 'init_lsp)
;;; init_lsp.el ends here
