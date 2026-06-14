;; -*- lexical-binding: t -*-

;; ============================================================
;; init.el — Emacs 主配置文件
;; ============================================================

;; A simple frame title
(setq frame-title-format '("%b - Emacs")
      icon-title-format frame-title-format)

;; ELPA 镜像配置 (中科大镜像)
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
(package-initialize)

;; use-package 编译时设置
(eval-when-compile
  (require 'use-package))

;; 让 use-package 默认 defer 以减少启动加载
(setq use-package-always-defer nil
      use-package-always-ensure nil
      use-package-expand-minimally nil
      use-package-enable-imenu-support t)

;; Keep ~/.emacs.d/ clean.
(use-package no-littering
  :ensure t)
(require 'no-littering)

;; 禁用 custom-file，避免 Customize 接口意外覆盖配置
(setq custom-file nil)
;; 完全阻止 Emacs 写入任何 custom 设置
(advice-add 'custom-save-all :override #'ignore)
(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))

;; ============================================================
;; 加载各个功能模块
;; ============================================================
(require 'init_base)
(require 'init_ui)
(require 'init_ivy)
(require 'init_tools)
(require 'init_text)
(require 'init_lsp)

;; ============================================================
;; 启动后报告启动耗时
;; ============================================================
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %.2f seconds with %d GCs"
					 (float-time (time-subtract after-init-time before-init-time))
                     gcs-done)))
