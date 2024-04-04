;;; init_base
;;; Code:

(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-x-resources t)
(setq inhibit-default-init t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-buffer-menu t)

(setq inhibit-splash-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(setq window-resize-pixelwise t)
(setq frame-resize-pixelwise t)

;; Linux specific
(setq x-gtk-use-system-tooltips nil)
(setq x-underline-at-descent-line t)

;; Optimize for very long lines
(setq bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; No backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; No gc for font caches
(setq inhibit-compacting-font-caches t)

;; Improve display
(setq display-raw-bytes-as-hex t)
(setq redisplay-skip-fontification-on-input t)

;; No annoying bell
(setq ring-bell-function 'ignore)

;; No eyes distraction
(setq blink-cursor-mode nil)
;; Smooth scroll & friends
(setq scroll-step 2)
(setq scroll-margin 4)
(setq hscroll-step 2)
(setq hscroll-margin 4)
(setq scroll-conservatively 101)
(setq scroll-preserve-screen-position 'always)

;; The nano style for truncated long lines.
(setq auto-hscroll-mode 'current-line)

;; Disable auto vertical scroll for tall lines
(setq auto-window-vscroll nil)

;; Dont move points out of eyes
(setq mouse-yank-at-point t)

;;(setq-default fill-column 80)
;;No tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; Sane defaults
(setq use-short-answers t)
(unless (>= emacs-major-version 28)
  (fset 'yes-or-no-p 'y-or-n-p))

;; Inhibit switching out from `y-or-n-p' and `read-char-choice'
(setq y-or-n-p-use-read-key t)
(setq read-char-choice-use-read-key t)

;; let's move lines more easilier ========================
;; move line up
(defun move-line-up ()
  "Move lines up by keybinds once, only swap two adjacent lines."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

;; move line down
(defun move-line-down ()
  "Move lines down by keybinds once, only swap two adjacent lines."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
;;==========================================================

(electric-pair-mode 1)

;; A simple frame title
(setq frame-title-format '("%b - Emacs")
      icon-title-format frame-title-format)
;; Highlight parenthesises
(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :custom
  (show-paren-when-point-inside-paren t)
  (show-paren-when-point-in-periphery t))

;; Highlight current line in GUI
(use-package hl-line
  :ensure nil
  :when (display-graphic-p)
  :hook (after-init . global-hl-line-mode))

(use-package text-mode
  :ensure nil
  :custom
  ;; better word wrapping for CJK characters
  (word-wrap-by-category t)
  ;; paragraphs
  (sentence-end "\\([，。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
  (sentence-end-double-space nil))

(use-package minibuffer
  :bind (:map minibuffer-local-map
              ([escape] . abort-recursive-edit)
              :map minibuffer-local-ns-map
              ([escape] . abort-recursive-edit)
              :map minibuffer-local-completion-map
              ([escape] . abort-recursive-edit)
              :map minibuffer-local-must-match-map
              ([escape] . abort-recursive-edit)
              :map minibuffer-local-isearch-map
              ([escape] . abort-recursive-edit))
  :custom
  (completion-auto-help t)
  (completion-show-help nil)
  ;; Cycle completions regardless of the count
  (completion-cycle-threshold t)
  (enable-recursive-minibuffers t)
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
  (completion-styles '(basic partial-completion substring flex))
  (completion-category-overrides '((buffer (styles . (flex)))))
  ;; vertical view
  (completions-format 'one-column)
  (completions-detailed t)
  )
;; Set language environment to UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(provide 'init_base)
;;; init_base.el ends here

