;; -*- lexical-binding: t -*-

(use-package gruber-darker-theme
  :ensure t
  :defer 0.5
  :config
  ;; 仿照 custom.el 的方式，通过 custom-set-variables 加载主题
  ;; 其内部 setter 会自动调用 load-theme，避免循环调用问题
  (custom-set-variables
   '(custom-enabled-themes '(gruber-darker))
   '(custom-safe-themes '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default)))
  (set-frame-font (font-spec :family "Monospace" :size 16)))

(provide 'init_ui)
