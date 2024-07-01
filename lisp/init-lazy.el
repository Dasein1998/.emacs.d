(provide 'init-lazy)
(use-package sort-tab
  :ensure t
  :defer t
  ;:after doom-modeline
  :vc (sort-tab :url "https://github.com/manateelazycat/sort-tab" :branch "main")
  :config
  (sort-tab-mode 1)
  )

(use-package auto-save
:ensure t
:vc (auto-save :url "https://github.com/manateelazycat/auto-save" :branch "master")
:config
(auto-save-enable)
(setq auto-save-silent t)   ; quietly save
(setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving

;;; custom predicates if you don't want auto save.
;;; disable auto save mode when current filetype is an gpg file.
(setq auto-save-disable-predicates
      '((lambda ()
      (string-suffix-p
      "gpg"
      (file-name-extension (buffer-name)) t))))
      )

(use-package lazy-load
:ensure t
:vc (lazy-load :url "https://github.com/manateelazycat/lazy-load" :branch "master")
)
(require 'lazy-load)
(lazy-load-global-keys
 '(
   ("M-7" . sort-tab-select-prev-tab)    ;选择前一个标签
   ("M-8" . sort-tab-select-next-tab)    ;选择后一个标签
   ("M-s-7" . sort-tab-select-first-tab) ;选择第一个标签
   ("M-s-8" . sort-tab-select-last-tab)  ;选择最后一个标签
   ("C-;" . sort-tab-close-current-tab)  ;关闭当前标签
   ("s-q" . sort-tab-close-other-tabs)   ;关闭后台标签
   ("s-Q" . sort-tab-close-all-tabs)     ;关闭所有标签
   )
 "sort-tab")
(lazy-load-global-keys
 '(
   ("M-o" . ace-window))
 "ace-window"
 )
(use-package awesome-tray
;;:disabled t
  :ensure t
  :vc (awesome-tray :url "https://github.com/manateelazycat/awesome-tray" :branch "master" )
  :config
  (awesome-tray-mode 1)
  (setq awesome-tray-date-format nil)
  (setq awesome-tray-hide-mode-line nil)
  )

  (use-package no-littering
    :ensure t
    :init
(require 'no-littering)
)