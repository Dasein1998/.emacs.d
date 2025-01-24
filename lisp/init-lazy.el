(provide 'init-lazy)
(use-package auto-save
:ensure t
:init (slot/vc-install :fetcher "github" :repo "manateelazycat/auto-save")
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

(use-package on
:init (slot/vc-install :fetcher "github" :repo "ajgrf/on.el")
:ensure t
)
