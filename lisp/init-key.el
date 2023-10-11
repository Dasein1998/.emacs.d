(provide 'init-key)
(use-package which-key
  :ensure t
  :hook
  (on-first-input . which-key-mode)
  )
(use-package avy
  :ensure t
  :bind
 ; (("M-j C-SPC" 、. avy-goto-char-timer))
  )
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)

(use-package hydra
  :ensure t
  :defer 2)
(use-package use-package-hydra
  :ensure t
  :defer 2
  :after hydra)
(use-package keyfreq
  :ensure t
  :defer 2
  :config
  (keyfreq-mode)
  (keyfreq-autosave-mode)
  )
(setq keyfreq-excluded-commands
      '(self-insert-command
        forward-char
        backward-char
        previous-line
        next-line))
