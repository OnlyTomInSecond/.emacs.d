;; -*- lexical-binding: t -*-

;;; init_base
;;; Code:

;; Settings for exec-path-from-shell
;; fix the PATH environment variable issue
;; (use-package exec-path-from-shell
;;   :ensure t
;;   :when (or (memq window-system '(mac ns x))
;;             )
;;   :init (exec-path-from-shell-initialize))

(setq inhibit-x-resources t
      inhibit-default-init t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      use-dialog-box nil
      use-file-dialog nil
      )
;; No bars and menus
(setq inhibit-splash-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;;(ido-mode 1)
;;(ido-everywhere 1)

;; Pixel sized window
;; (setq window-resize-pixelwise t
;;       frame-resize-pixelwise t)

;; Linux specific
;;(setq x-gtk-use-system-tooltips t
;;      x-underline-at-descent-line t)

;; No ToolTip under mouse, just display in minibuffer
(tooltip-mode -1)
;; Change text direction to "left-to-right"
;; (setq bidi-paragraph-direction 'left-to-right
;;       bidi-inhibit-bpa t)

;; No backup files
(setq make-backup-files nil
      auto-save-default nil)
;; No lock file
(setq create-lockfiles nil)

;; No gc for font caches
(setq inhibit-compacting-font-caches t)

;; Improve display
;; (setq display-raw-bytes-as-hex t)
;; (setq redisplay-skip-fontification-on-input t)

;; No annoying bell
(setq ring-bell-function 'ignore)

;; No eyes distraction
(blink-cursor-mode 0)
;; Smooth scroll & friends
;; (setq scroll-step 2
;;       scroll-margin 4
;;       hscroll-step 2
;;       hscroll-margin 4
;;       scroll-conservatively 50
;;       scroll-preserve-screen-position 'always)

;; The nano style for truncated long lines.
;; (setq auto-hscroll-mode 'current-line)

;; Disable auto vertical scroll for tall lines
(setq auto-window-vscroll nil)

;; Dont move points out of eyes
(setq mouse-yank-at-point t)

;;(setq-default fill-column 80)
;; No tabs
;;(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-always-indent 'complete)
;; Sane defaults
(setq use-short-answers t)
(unless (>= emacs-major-version 28)
  (fset 'yes-or-no-p 'y-or-n-p))

;; Inhibit switching out from `y-or-n-p' and `read-char-choice'
;; (setq y-or-n-p-use-read-key t)
;; (setq read-char-choice-use-read-key t)

(electric-pair-mode 1)

;; show all space and tabs
;;(use-package whitespace-mode
;;  :defer 1
;;  :hook (prog-mode . whitespace-mode)
;;  :custom
;;  (
;;    (whitespace-big-indent ((t nil)))
;;    )
;;  )

;; enable windmove
;; (windmove-default-keybindings)
;; (setq window-wrap-around t)
;; allow restore window
;; (winner-mode 1)

;; move-dup, move/copy line or region
;; (use-package move-dup
;;   :ensure t
;;   :defer 1
;;   :hook (after-init . global-move-dup-mode))

;; Highlight parenthesises
;; (use-package paren
;;   :ensure nil
;;   :defer 1
;;   :hook (after-init . show-paren-mode)
;;   :custom
;;   (show-paren-when-point-inside-paren t)
;;   (show-paren-when-point-in-periphery t)
;;   )

;; Highlight current line in GUI
;; (use-package hl-line
;;   :ensure nil
;;   :defer 1
;;   :when (display-graphic-p)
;;   :hook (after-init . global-hl-line-mode))

;; (use-package text-mode
;;   :ensure nil
;;   :defer t
;;   :custom
;;   ;; better word wrapping for CJK characters
;;   (word-wrap-by-category t)
;;   ;; paragraphs
;;   (sentence-end "\\([，。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
;;   (sentence-end-double-space nil))

(use-package minibuffer
  :defer t
  ;; :bind (:map minibuffer-local-map
  ;;             ([escape] . abort-recursive-edit)
  ;;             :map minibuffer-local-ns-map
  ;;             ([escape] . abort-recursive-edit)
  ;;             :map minibuffer-local-completion-map
  ;;             ([escape] . abort-recursive-edit)
  ;;             :map minibuffer-local-must-match-map
  ;;             ([escape] . abort-recursive-edit)
  ;;             :map minibuffer-local-isearch-map
  ;;             ([escape] . abort-recursive-edit))
  :custom
  (completion-auto-help t)
  (completion-show-help nil)
  ;; Cycle completions regardless of the count
  (completion-cycle-threshold nil)
  ;;(enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode t)
  (minibuffer-eldef-shorten-default t)
  (minibuffer-electric-default-mode t)
  ;; One frame one minibuffer.
  (minibuffer-follows-selected-frame nil)
  ;; Ignore cases when complete
  (completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  ;; `selectrum', `vertico' and `icomplete' will honoring
  ;; (completion-styles '(basic partial-completion substring flex))
  (completion-category-overrides '((buffer (styles . (flex)))))
  ;; vertical view
  ;; (completions-format 'one-column)
  ;; (completions-detailed t)
  )
;; Set language environment to UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Enable visual-line-mode
;;(global-visual-line-mode 1)

;; auto update packages
;;(use-package auto-package-update
;;  :ensure t
;;  :defer 1
;;  :custom
;;  (auto-package-update-interval 7)
;;  (auto-package-update-prompt-before-update t)
;;  (auto-package-update-hide-results t)
;;  :config
;;  (auto-package-update-maybe)
;;  (auto-package-update-at-time "09:00")
;;  )

;; vterm
;; (use-package vterm
;;   :ensure t
;;   :defer 1
;;   )

;; (setq project-vc-extra-root-markers '(".project.el" ".projectile" ".ccls"))

;;(use-package benchmark-init
;;  :ensure t
;;  :config
  ;; To disable collection of benchmark data after init is done.
;;  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(provide 'init_base)
;;; init_base.el ends here
