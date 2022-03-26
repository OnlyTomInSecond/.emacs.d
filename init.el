
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)



;;config the elpa mirror in China
(require 'package)
(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("stable-melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
			 ))
(package-initialize) ;; You might already have this line

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure nil)
  (setq use-package-always-defer nil)
  (setq use-package-always-demand nil)
  (setq use-package-expand-minimally nil)
  (setq use-package-enable-imenu-support t))
(eval-when-compile
  (require 'use-package))

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

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :hook (after-init . ivy-mode))

(global-linum-mode 1)
;;(global-display-line-numbers-mode t)
;;(setq 'custom-file "~/.emacs.d/custom.el"
;; Disable Custom settings when exist
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
   (when (file-exists-p custom-file)
       (load custom-file))
(add-to-list 'load-path "~/.emacs.d/lisp/" )
;;
;;====================

(require 'init_ui)
(require 'init_base)
;;(require 'init_helm)
(require 'init_tools)
(require 'init_lsp)
(require 'init_ctags)
(require 'init_text)


