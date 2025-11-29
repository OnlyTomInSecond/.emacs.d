;; -*- lexical-binding: t -*-

;;(use-package counsel
;;  :ensure t
;;  :defer t
;;  :hook (after-init . counsel-mode)
;;  :config (ivy-mode 1)
;;
;;  :custom
;;  ;;(ivy-use-virtual-buffers t) ;; For recent file
;;  (ivy-count-format "%d/%d ")
;;  ;;(ivy-use-selectable-prompt t)
;;
;;  :bind (
;;         ;;Ivy-based interface to standard commands
;;         ("C-s" . swiper-isearch)
;;         ("M-x" . counsel-M-x)
;;         ("C-x C-f" . counsel-find-file)
;;         ("M-y" . counsel-yank-pop)
;;         ("<f1> f" . counsel-describe-function)
;;         ("<f1> v" . counsel-describe-variable)
;;         ("<f1> l" . counsel-find-library)
;;         ("<f2> i" . counsel-info-lookup-symbol)
;;         ("<f2> u" . counsel-unicode-char)
;;         ("<f2> j" . counsel-set-variable)
;;         ("C-x b" . ivy-switch-buffer)
;;         ("C-c v" . ivy-push-view)
;;         ("C-c V" . ivy-pop-view)
;;         ;;Ivy-based interface to shell and system tools
;;         ("C-c c" . counsel-compile)
;;         ("C-c g" . counsel-git)
;;         ("C-c j" . counsel-git-grep)
;;         ("C-c L" . counsel-git-log)
;;         ("C-c k" . counsel-rg)
;;         ("C-c m" . counsel-linux-app)
;;         ("C-c n" . counsel-fzf)
;;         ("C-x l" . counsel-locate)
;;         ("C-c J" . counsel-file-jump)
;;         ("C-S-o" . counsel-rhythmbox)
;;         ("C-c w" . counsel-wmctrl)
;;         ;;Ivy-resume and other commands
;;         ("C-c C-r" . ivy-resume)
;;         ("C-c b" . counsel-bookmark)
;;         ("C-c d" . counsel-descbinds)
;;         ("C-c g" . counsel-git)
;;         ("C-c o" . counsel-outline)
;;         ("C-c t" . counsel-load-theme)
;;         ("C-c F" . counsel-org-file)
;;         )
;;  )

;; (use-package smex
;;   :ensure t
;;   :defer t
;;   :after (counsel)
;;   )

;; use vertico+orderless+consult

(use-package vertico
  :ensure t
  :defer 1
  :hook (after-init . vertico-mode)
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  )

(use-package savehist
  :ensure t
  :defer 0.5
  :hook (after-init . savehist-mode)
  )

(use-package orderless
  :ensure t
  :defer 0.5
  ;; :config
  ;; (setq
  ;;  completion-styles '(orderless partial-completion flex substring)
  ;;  completion-category-defaults nil
  ;;  completion-category-overrides '(
  ;;                                  (file (styles basic partial-completion))
  ;;                                  ;;(eglot (styles orderless))
  ;;                                  ))
  :custom
  ;; (completion-styles '(orderless partial-completion flex substring))
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '(
                                   (file (styles partial-completion))
                                   ;;(eglot (styles orderless))
                                   ))
  )

;; (use-package consult
;;   :ensure t
;;   :defer 1
;;   :bind
;;   ("C-s" . consult-line)
;;   )

;; Example configuration for Consult
(use-package consult
  :ensure t
  :defer 1
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ;; ("C-c M-x" . consult-mode-command)
         ;; ("C-c h" . consult-history)
         ;; ("C-c k" . consult-kmacro)
         ;; ("C-c m" . consult-man)
         ;; ("C-c i" . consult-info)
         ;; ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ;; ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ;; ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ;; ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ;; ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ;; ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ;; ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ;; ("M-#" . consult-register-load)
         ;; ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ;; ("C-M-#" . consult-register)
         ;; Other custom bindings
         ;; ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ;; ("M-g e" . consult-compile-error)
         ;; ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ;; ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ;; ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ;; ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ;; ("M-g m" . consult-mark)
         ;; ("M-g k" . consult-global-mark)
         ;; ("M-g i" . consult-imenu)
         ;; ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ;; ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ;; ("M-s c" . consult-locate)
         ;; ("M-s g" . consult-grep)
         ;; ("M-s G" . consult-git-grep)
         ;; ("M-s r" . consult-ripgrep)
         ;; ("M-s l" . consult-line)
         ;; ("M-s L" . consult-line-multi)
         ;; ("M-s k" . consult-keep-lines)
         ;; ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ;; ("M-s e" . consult-isearch-history)
         ;; :map isearch-mode-map
         ;; ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ;; ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ;; ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ;; ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; ;; Minibuffer history
         ;; :map minibuffer-local-map
         ;; ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ;; ("M-r" . consult-history)                 ;; orig. previous-matching-history-element
		 )

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
  )

(provide 'init_ivy)
