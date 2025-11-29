;; -*- lexical-binding: t -*-

;;(setq gc-cons-percentage 0.1)

;; A simple frame title
(setq frame-title-format '("%b - Emacs")
      icon-title-format frame-title-format)

;;config the elpa mirror in China
;;(require 'package)
;; (setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                          ("melpa"  . "Https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;;(setq package-archives '(("gnu"    . "https://mirrors.bfsu.edu.cn/elpa/gnu/")
;;                         ("nongnu" . "https://mirrors.bfsu.edu.cn/elpa/nongnu/")
;;                         ("melpa"  . "https://mirrors.bfsu.edu.cn/elpa/melpa/")))
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
(package-initialize) ;; You might already have this line
;;Avoid execute package-refresh-contents many times
;;(when (not package-archive-contents)
;;  (package-refresh-contents))
;; Bootstrap `use-package'
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;; (eval-and-compile
;;   (setq use-package-always-ensure nil)
;;   (setq use-package-always-defer nil)
;;   (setq use-package-always-demand nil)
;;   (setq use-package-expand-minimally nil)
;;   (setq use-package-enable-imenu-support t))
(eval-when-compile
  (require 'use-package))

;;Keep ~/.emacs.d/ clean.
(use-package no-littering
  :ensure t)

;; I wanna newer packages.
;; (setq package-install-upgrade-built-in t)


;; Bootstrap `quelpa'.
;; (use-package quelpa
;;   :ensure t
;;   :commands quelpa
;;   :custom
;;   (quelpa-git-clone-depth 1)
;;   (quelpa-self-upgrade-p nil)
;;   (quelpa-update-melpa-p nil)
;;   (quelpa-checkout-melpa-p nil))

;; show line numbers and column numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
;; (column-number-mode 1)

;; (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (when (file-exists-p custom-file)
;;   (load custom-file))

(add-to-list 'load-path "~/.emacs.d/lisp/" )
;;
;;====================

;; Set proxy
;;(setq url-proxy-services '(("http" . "127.0.0.1:9080")
;;                           ("https" . "127.0.0.1:9080")
;;                           ))

(require 'init_base)
(require 'init_ui)
(require 'init_ivy)
(require 'init_tools)
;;(require 'init_ggtags)
(require 'init_text)
(require 'init_lsp)
;;(require 'init_etags)

;;Use a hook so the message doesn't get clobbered by other messages.
;;(add-hook 'emacs-startup-hook
;;		  (lambda ()
;;			(message "Emacs ready in %s with %d garbage collections."
;;					 (format "%.2f seconds"
;;							 (float-time
;;							  (time-subtract after-init-time before-init-time)))
;;					 gcs-done)))
;;
;;(setq gc-cons-threshold (* 10 1024 1024))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
