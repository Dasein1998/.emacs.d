(provide 'init-avy)
(use-package ace-pinyin
  :ensure t
  :defer t
  :after avy
  :config
(ace-pinyin-global-mode 1)
)
(use-package avy
  :ensure t
  :defer t
  :bind
  ;;(("M-j C-SPC" 、. avy-goto-char-timer))
  )
(global-set-key (kbd "C-:")'avy-goto-char)
(global-set-key (kbd "M-g f")'avy-goto-line)
(global-set-key (kbd "M-g w")'avy-goto-word-1)
;; https://github.com/abo-abo/ace-window
(use-package ace-window
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defvar aw-dispatch-alist
    '((?x aw-delete-window "Delete Window")
      (?m aw-swap-window "Swap Windows")
      (?M aw-move-window "Move Window")
      (?c aw-copy-window "Copy Window")
      (?j aw-switch-buffer-in-window "Select Buffer")
      (?n aw-flip-window)
      (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
      (?c aw-split-window-fair "Split Fair Window")
      (?v aw-split-window-vert "Split Vert Window")
      (?b aw-split-window-horz "Split Horz Window")
      (?o delete-other-windows "Delete Other Windows")
      (?? aw-show-dispatch-help))
    "List of actions for `aw-dispatch-default'.")
  )
