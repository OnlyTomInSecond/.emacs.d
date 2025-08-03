;; -*- lexical-binding: t -*-

;; configuration for company mode and lsp
;;(use-package company
;;  :ensure t
;;  :defer 1
;;  :hook (prog-mode . company-mode)
;;  ;; :bind (
;;  ;;        :map company-mode-map
;;  ;;        ([remap completion-at-point] . company-complete)
;;  ;;        :map company-active-map
;;  ;;        ;;("C-s"     . company-filter-candidates)
;;  ;;        ([tab]     . company-complete-common-or-cycle)
;;  ;;        ([backtab] . company-select-previous-or-abort)
;;  ;;        )
;;
;;  :custom
;;;;    (company-backends '(company-capf
;;;;                        (company-dabbrev-code company-dabbrev company-abbrev company-etags company-keywords company-files)
;;;;                        )
;;;;                      )
;;  (company-idle-delay 0.3)
;;  ;; Easy navigation to candidates with M-<n>
;;  (company-show-quick-access t)
;;  (company-require-match nil)
;;  (completion-ignore-case t)
;;  (company-minimum-prefix-length 3)
;;  ;;(company-selection-wrap-around t)
;;  (company-tooltip-width-grow-only t)
;;  (company-tooltip-align-annotations t)
;;  ;; complete `abbrev' only in current buffer and make dabbrev case-sensitive
;;  (company-dabbrev-other-buffers nil)
;;  ;;(company-dabbrev-ignore-case nil)
;;  ;;(company-dabbrev-downcase nil)
;;  ;; make dabbrev-code not case-sensitive
;;  (company-dabbrev-code-ignore-case t)
;;  (company-dabbrev-code-everywhere t)
;;  ;; call `tempo-expand-if-complete' after completion
;;  ;; (company-tempo-expand t)
;;  ;; Ignore uninteresting files. Items end with a slash are recognized as
;;  ;; directories.
;;  (company-files-exclusions '(".git/" ".DS_Store"))
;;  ;; No icons
;;  (company-format-margin-function nil)
;;  )

(use-package corfu
  :defer 1
  :ensure t
  ;; Optional customizations
  :bind
  ;; Configure SPC for separator insertion
  (:map corfu-map ("s-SPC" . corfu-insert-separator))
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-quit-at-boundary 'nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match 'separator)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect 'insert)      ;; Preselect the prompt
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;;(corfu-separator ?/s)

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode)
  )

;; A few more useful configurations...
(use-package emacs
  :defer 1
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  ;; (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :defer 1
;;  :bind (("M-/" . dabbrev-completion)
;;         ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  ;; Since 29.1, use `dabbrev-ignored-buffer-regexps' on older.
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

;; (use-package company-c-headers
;;   :ensure t
;;   :after (company)
;;   :hook (((c-mode c++-mode) . (lambda ()
;;                                 (add-to-list 'company-backends 'company-c-headers t)))
;;          (c++-mode . (lambda ()
;;                        (add-to-list 'company-c-headers-path-system "/usr/include/c++/13.2.1/")
;;                        ;; For termux
;;                        ;; (add-to-list 'company-c-headers-path-system "~/../usr/include/c++/v1/")
;;                        ))
;;          )
;;   )
;; ==============================================================================
;; lsp-mode
;; (use-package lsp-mode
;;   :ensure t
;;   :config
;;   ;; set lsp-mode keymap
;;   (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)

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

;; ;; optionally
;; (use-package lsp-ui
;;   :ensure t
;;   :custom
;;   (lsp-ui-doc-enable nil)                   ;;disable lsp-ui-doc
;;   (lsp-ui-sideline-enable nil)              ;;disable sideline
;;   (lsp-ui-sideline-show-hover nil)          ;;don't show hover messages in sideline
;;   )

;; ;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; ======================================================================

;;eglot
;;Language Server (eglot - builtin since v29)
(use-package eglot
  ;;:bind ("C-c e f" . eglot-format)
  :ensure t
  :hook (prog-mode . (lambda () (unless (member major-mode '(emacs-lisp-mode))
			                      (eglot-ensure))))
  ;; :init
  ;; (add-hook 'prog-mode-hook
  ;;           (lambda () (unless (member major-mode '(emacs-lisp-mode cmake-mode))
  ;;   		             (eglot-ensure))))

  :config
  ;;   (add-to-list 'eglot-server-programs
  ;;                '((c-mode c-ts-mode c++-mode c++-ts-mode c-or-c++-mode c-or-c++-ts-mode)
  ;;                  . ("~/.emacs.d/bin/ccls.sh"))
  ;;                )
  (setq eglot-server-programs
        (nconc '(
                 ((c-mode c-ts-mode c++-mode c++-ts-mode c-or-c++-mode c-or-c++-ts-mode)
                  . ("/home/whh/.emacs.d/bin/ccls.sh"))
                 ;;((cmake-mode cmake-ts-mode) . ("cmake-language-server"
                 ;;                               :initializationOptions
                 ;;                               (:buildDirectory "build")
                 ;;                               ))
                 )
               eglot-server-programs
               )
        )
  ;; :custom
  ;; (eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider))
  ;;(setq eglot-stay-out-of '(company))
  )

;; ccls
;; (use-package ccls
;;   :ensure t

;;   :custom
;;   (ccls-executable "~/.emacs.d/bin/ccls.sh")
;;   )

;; (use-package cc-mode
;;   ;;:ensure t
;;   :config
;;   (setq c-default-style '((java-mode . "java")
;;                           (awk-mode . "awk")
;;                           (other . "linux"))
;;         )
;;   (setq c-basic-offset 4)
;;   )

;; Enable Code Folding
(use-package hideshow
  :ensure t
  :defer 1
  :hook (prog-mode . hs-minor-mode)
  )
;; (use-package cmake-mode
;;   :ensure t
;;   :defer t
;;   )

(use-package treesit
  :ensure nil ;;Builtin in emacs 29
  :config
  (setq treesit-language-source-alist
        '((bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
 		  (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
 		  (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
 		  ;;(css        . ("https://github.com/tree-sitter/tree-sitter-css"))
 		  (cmake      . ("https://github.com/uyha/tree-sitter-cmake"))
 		  ;;(csharp     . ("https://github.com/tree-sitter/tree-sitter-c-sharp.git"))
 		  ;;(dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
 		  (elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
 		  ;;(go         . ("https://github.com/tree-sitter/tree-sitter-go"))
 		  ;;(gomod      . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))
 		  ;;(html       . ("https://github.com/tree-sitter/tree-sitter-html"))
 		  (java       . ("https://github.com/tree-sitter/tree-sitter-java.git"))
 		  ;;(javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
 		  ;;(json       . ("https://github.com/tree-sitter/tree-sitter-json"))
 		  ;;(lua        . ("https://github.com/Azganoth/tree-sitter-lua"))
 		  (make       . ("https://github.com/alemuller/tree-sitter-make"))
 		  (markdown   . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
 		  ;;(ocaml      . ("https://github.com/tree-sitter/tree-sitter-ocaml" nil "ocaml/src"))
 		  (org        . ("https://github.com/milisims/tree-sitter-org"))
 		  (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
 		  ;;(php        . ("https://github.com/tree-sitter/tree-sitter-php"))
 		  ;;(typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
 		  ;;(tsx        . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
 		  ;;(ruby       . ("https://github.com/tree-sitter/tree-sitter-ruby"))
 		  (rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
 		  ;;(sql        . ("https://github.com/m-novikov/tree-sitter-sql"))
 		  ;;(vue        . ("https://github.com/merico-dev/tree-sitter-vue"))
 		  ;;(yaml       . ("https://github.com/ikatyang/tree-sitter-yaml"))
 		  ;;(toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))
 		  ;;(zig        . ("https://github.com/GrayJack/tree-sitter-zig"))
 		  ))
  )

(use-package treesit-auto
  :ensure t
  :defer 1
  ;;:after (treesit)
  :hook (prog-mode . global-treesit-auto-mode)
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
;; This needs clang-format,yapf(python),shfmt,astyle installed
(use-package format-all
  :ensure t
  :defer 1
  ;;:commands format-all-mode
  ;;:hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(
				  ;;("C" (clang-format "--style={BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4}"))
				  ;;("C++" (clang-format "--style={BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4}"))
				  ("C" (clang-format "--style=file:/home/whh/.emacs.d/configs/clang-format"))
				  ("C++" (clang-format "--style=file:/home/whh/.emacs.d/configs/clang-format"))
				  ;; ("C" (astyle "--style=gnu"))
				  ;; ("C++" (astyle "--style=gnu"))
				  ("Python" (yapf "--style" "google"))
				  ("Shell" (shfmt "-i" "4" "-ci"))
				  ("Java" (astyle "--mode=java"))
                  ("CMake" (cmake-format))
				  ;;("JavaScript" (prettier))
				  )
                )
  :bind (
         ("C-M-\\" . format-all-region)
         )
  )

;; (use-package flycheck
;;   :ensure t
;;   :hook (prog-mode . flycheck-mode)
;;   )

;; flymake shotkeys
(global-set-key (kbd "M-n") #'flymake-goto-next-error)
(global-set-key (kbd "M-p") #'flymake-goto-prev-error)

(use-package yasnippet
  :ensure t
  :defer 1
  :hook (prog-mode . yas-minor-mode)
  )

(use-package yasnippet-snippets
  :ensure t
  :defer 1
  )

;; (use-package company-dict
;;   :ensure t
;;   )

;;(use-package projectile
;;  :ensure t
;;  :defer 1
;;  :hook (prog-mode . projectile-mode)
;;  :bind (:map projectile-mode-map
;;              ;;("s-p" . projectile-command-map)
;;              ("C-c p" . projectile-command-map))
;;  ;;:custom
;;  ;;(projectile-completion-system 'ivy)
;;  )
(provide 'init_lsp)
;;; init_lsp.el ends here
