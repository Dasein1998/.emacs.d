(provide 'init-project)
(use-package projectile
  :bind (("C-c p" . projectile-command-map))
  :config
  (setq projectile-mode-line "Projectile")
  (setq projectile-track-known-projects-automatically nil))

;(use-package counsel-projectile
 ; :ensure t
  ;:after (projectile)
  ;:init (counsel-projectile-mode))
(use-package magit
  :defer t
  )
