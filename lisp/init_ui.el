;; -*- lexical-binding: t -*-

(use-package dracula-theme
  :ensure t
  :defer 0.5
  :config
  (custom-set-variables
   '(custom-safe-themes
	 '("0223215a464167d93b9cfef9b1cdf9b0768ab660f33b3068b647f7b12aa453a0"
	   "01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd"
	   "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
	   default))
   '(custom-enabled-themes '(dracula))
   )
  )


(provide 'init_ui)
