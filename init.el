;;config the elpa mirror in China
(require 'package)
(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;;(package-initialize) ;; You might already have this line

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  ;; (setq use-package-always-ensure nil)
  (setq use-package-always-defer nil)
  (setq use-package-always-demand nil)
  ;; (setq use-package-expand-minimally nil)
  (setq use-package-enable-imenu-support t))
(eval-when-compile
  (require 'use-package))

;; I wanna newer packages.
(setq package-install-upgrade-built-in t)

;; Keep ~/.emacs.d/ clean.
(use-package no-littering
  :ensure t
  :demand t)

;; Bootstrap `quelpa'.
(use-package quelpa
  :ensure t
  :commands quelpa
  :custom
  (quelpa-git-clone-depth 1)
  (quelpa-self-upgrade-p nil)
  (quelpa-update-melpa-p nil)
  (quelpa-checkout-melpa-p nil))

;; show line numbers and column numbers
(global-display-line-numbers-mode 1)
(column-number-mode 1)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
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
(require 'init_lsp)
;;(require 'init_etags)
(require 'init_text)

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
    (lambda ()
        (message "Emacs ready in %s with %d garbage collections."
            (format "%.2f seconds"
                (float-time
                    (time-subtract after-init-time before-init-time)))
        gcs-done)))

;; (setq gc-cons-threshold (* 10 1024 1024))
