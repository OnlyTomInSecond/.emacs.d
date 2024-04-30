(use-package counsel
  :ensure t
  :defer t
  :hook (after-init . counsel-mode)
  :config (ivy-mode 1)

  :custom
  ;;(ivy-use-virtual-buffers t) ;; For recent file
  (ivy-count-format "%d/%d ")
  ;;(ivy-use-selectable-prompt t)

  :bind (
         ;;Ivy-based interface to standard commands
         ("C-s" . swiper-isearch)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("M-y" . counsel-yank-pop)
         ("<f1> f" . counsel-describe-function)
         ("<f1> v" . counsel-describe-variable)
         ("<f1> l" . counsel-find-library)
         ("<f2> i" . counsel-info-lookup-symbol)
         ("<f2> u" . counsel-unicode-char)
         ("<f2> j" . counsel-set-variable)
         ("C-x b" . ivy-switch-buffer)
         ("C-c v" . ivy-push-view)
         ("C-c V" . ivy-pop-view)
         ;;Ivy-based interface to shell and system tools
         ("C-c c" . counsel-compile)
         ("C-c g" . counsel-git)
         ("C-c j" . counsel-git-grep)
         ("C-c L" . counsel-git-log)
         ("C-c k" . counsel-rg)
         ("C-c m" . counsel-linux-app)
         ("C-c n" . counsel-fzf)
         ("C-x l" . counsel-locate)
         ("C-c J" . counsel-file-jump)
         ("C-S-o" . counsel-rhythmbox)
         ("C-c w" . counsel-wmctrl)
         ;;Ivy-resume and other commands
         ("C-c C-r" . ivy-resume)
         ("C-c b" . counsel-bookmark)
         ("C-c d" . counsel-descbinds)
         ("C-c g" . counsel-git)
         ("C-c o" . counsel-outline)
         ("C-c t" . counsel-load-theme)
         ("C-c F" . counsel-org-file)
         )
  )

(use-package smex
  :ensure t
  :defer t
  :after (counsel)
  )

(provide 'init_ivy)
