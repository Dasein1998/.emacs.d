(provide 'init-avy)

(use-package ace-pinyin
  :ensure t
  (ace-pinyin-global-mode 1)
  )
(use-package avy
  :ensure t
  :bind
 ; (("M-j C-SPC" 、. avy-goto-char-timer))
  )
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
; https://github.com/abo-abo/ace-window
(use-package ace-window
:ensure t
:config
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
)
