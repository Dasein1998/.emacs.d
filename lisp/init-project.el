(provide 'init-project)
(use-package magit
  :disabled t
  :defer t
  )

(use-package projectile
:defer t
:ensure t
:config
(projectile-mode 1)
)
