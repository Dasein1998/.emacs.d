(provide 'init-dired)
(use-package dired-preview
  :defer t
  :ensure t )
(use-package dired
  :ensure nil
  :custom
  (dired-kill-when-opening-new-dired-buffer t))
