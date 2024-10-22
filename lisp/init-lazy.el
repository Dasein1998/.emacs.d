(provide 'init-lazy)

(use-package auto-save
:ensure (:host github :repo "manateelazycat/auto-save")
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

;; (use-package no-littering
;;     :ensure t
;;     :init
;;     (require 'no-littering)
;; )

(elpaca '(pyim-humadict :host github :repo "Dasein1998/huma_pyim"))
(use-package on
:ensure(:repo "ajgrf/on.el" :host github )
)
(use-package blink-search
:ensure(:repo "manateelazycat/blink-search" :host github )
)
(add-to-list 'load-path "~/.emacs.d/elpaca/repos/blink-search")
(require 'blink-search)
;; pip3 install epc requests