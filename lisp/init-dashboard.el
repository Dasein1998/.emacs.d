(provide 'init-dashboard)
(use-package benchmark-init
  :ensure (:wait t)
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
)


