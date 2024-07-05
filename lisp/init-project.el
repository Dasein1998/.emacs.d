(provide 'init-project)
(use-package magit
  :defer t
)

(use-package projectile
:defer t
:ensure t
:config
(projectile-mode 1)
)
