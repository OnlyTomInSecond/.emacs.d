;; -*- lexical-binding: t -*-

;; ============================================================
;; early-init.el — Emacs 27+ 启动早期优化
;; 此文件在 GUI 初始化之前运行，是性能优化的关键位置
;; ============================================================

;; 启动期间将 GC 阈值设为极大值，避免 GC 暂停
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; 阻止 Emacs 在启动时自动加载 package.el
;; init.el 中会手动调用 package-initialize
(setq package-enable-at-startup nil)

;; 阻止 Emacs 启动画面/帮助画面
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-splash-screen t
      inhibit-default-init t
      inhibit-x-resources t)

;; 阻止 frame 在启动时 resize，减少 UI 开销
(setq frame-inhibit-implied-resize t)

;; 预配置默认 frame 参数 — 比在 init.el 中调用菜单模式更快
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; 临时清空 file-name-handler-alist 加速文件加载
;; 在 emacs-startup-hook 中恢复
(defvar my--early-init-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Native Comp 设置：抑制烦人的警告
(when (fboundp 'native-comp-available-p)
  (setq native-comp-async-report-warnings-errors nil
        native-comp-jit-compilation t))

;; URL 连接设置：减少 HTTPS 安全检查延迟 (仅 ELPA 镜像使用)
(eval-when-compile
  (require 'url))
(setq url-gateway-method 'native
      url-queue-timeout 30)

;; 在启动完成后恢复关键变量
(add-hook 'emacs-startup-hook
          (lambda ()
            ;; 恢复 file-name-handler-alist
            (setq file-name-handler-alist
                  my--early-init-file-name-handler-alist)
            ;; 重置 GC 阈值为合理值，避免启动后 GC 永不触发
            (setq gc-cons-threshold (* 64 1024 1024)
                  gc-cons-percentage 0.1)))

;; 启动后空闲 5 秒再执行一次完整 GC，整理碎片
(run-with-idle-timer 5 nil
                     (lambda ()
                       (garbage-collect)
                       (message "Early-init: initial GC done")))

(provide 'early-init)
