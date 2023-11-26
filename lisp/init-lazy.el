(provide 'init-lazy)
(use-package sort-tab
  :ensure t
  :vc (sort-tab :url "https://github.com/manateelazycat/sort-tab" :branch "main")
  :config
  (sort-tab-mode 1)
  :bind
  ("M-1" . sort-tab-select-visible-tab)
  ("M-2" . sort-tab-select-visible-tab)
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