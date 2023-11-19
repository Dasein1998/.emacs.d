(provide 'init-roam)
(setq org-modules nil)
(use-package org-roam
  :ensure t
  :defer t
  :config
  :hook (after-init . org-mode)
  )

(use-package org-roam-ui
  :ensure t
  :defer t
  :config
  :after (org-roam)
  )
