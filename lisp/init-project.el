(provide 'init-project)
(use-package transient
  :ensure t)
(use-package magit
  :after transient
  :defer t
)

(use-package projectile
:defer t
:ensure t
:config
(projectile-mode 1)
)
