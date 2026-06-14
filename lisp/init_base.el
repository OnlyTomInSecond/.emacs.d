;; -*- lexical-binding: t -*-

;;; init_base
;;; Code:

;; 以下基础设置已移到 early-init.el:
;;   - menu-bar-mode / tool-bar-mode / scroll-bar-mode (通过 default-frame-alist)
;;   - inhibit-startup-screen / inhibit-splash-screen 等

(setq use-dialog-box nil
      use-file-dialog nil)

;; 相对行号 —— 启动后空闲 1 秒再启用，避免启动时大量 font-lock 开销
(run-with-idle-timer 0.5 nil
					 (lambda ()
					   (setq display-line-numbers-type 'relative)
					   (global-display-line-numbers-mode 1)))

;; No ToolTip under mouse, just display in minibuffer
(tooltip-mode -1)

;; No backup files
(setq make-backup-files nil
      auto-save-default nil)
(setq create-lockfiles nil)

;; No gc for font caches
(setq inhibit-compacting-font-caches t)

;; ============================================================
;; 全局性能优化设置
;; ============================================================

;; 增加进程 IO buffer 大小 —— 提升 LSP 服务器通信速度
(setq read-process-output-max (* 4 1024 1024))

;; 输入时跳过 fontification，提升响应速度
(setq redisplay-skip-fontification-on-input t)

;; 快速但粗略的滚动 —— 大文件滚动更流畅
(setq fast-but-imprecise-scrolling t)

;; 禁止鼠标自动滚动（避免滚动时重新 fontify）
(setq mouse-wheel-progressive-speed nil)

;; Native Compilation 设置 (Emacs 29+)
(when (fboundp 'native-comp-available-p)
  (setq native-comp-async-report-warnings-errors 'silent)
  (setq native-comp-jit-compilation t))

;; 减少自动保存频率
(setq auto-save-interval 500
      auto-save-timeout 30)

;; 禁用不常用的内置功能以减少内存占用
(setq history-length 200
      history-delete-duplicates t
      message-log-max 200)

;; 长行优化：Emacs 29+ 内置长行检测
(setq long-line-threshold 500
      large-hscroll-threshold 2000)

;; 大文件警告阈值 50MB
(setq large-file-warning-threshold (* 50 1024 1024))

(use-package emacs
  :defer t
  :config
  (setq-default tab-width 4)
  (set-frame-font (font-spec :family "Monospace" :size 16))
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  ;; No blinking cursor
  (blink-cursor-mode 0)

  ;; Disable auto vertical scroll for tall lines
  (auto-window-vscroll nil)

  ;; Paste at point, not at mouse cursor
  (mouse-yank-at-point t)

  ;; No annoying bell
  (ring-bell-function 'ignore)

  ;; Auto pair brackets
  (electric-pair-mode 1)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; Use shorter answers (y/n instead of yes/no)
(setq use-short-answers t)
(unless (>= emacs-major-version 28)
  (fset 'yes-or-no-p 'y-or-n-p))

;; 上下移动行/选区 (Alt+↑/↓)
(use-package move-dup
  :ensure t
  :hook (after-init . global-move-dup-mode))

;; Minibuffer 设置
(use-package minibuffer
  :defer t
  :custom
  (completion-auto-help t)
  (completion-show-help nil)
  (completion-cycle-threshold nil)
  (minibuffer-depth-indicate-mode t)
  (minibuffer-eldef-shorten-default t)
  (minibuffer-electric-default-mode t)
  (minibuffer-follows-selected-frame nil)
  (completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-category-overrides '((buffer (styles . (flex)))))
  )

;; UTF-8 everywhere
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(provide 'init_base)
;;; init_base.el ends here
