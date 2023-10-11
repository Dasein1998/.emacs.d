(provide 'init-hyperbole)

(use-package hyperbole
  :ensure t
  :hook
  (on-first-buffer-hook . hyperbole-mode)
  )
