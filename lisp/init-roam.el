(provide 'init-roam)
(use-package org-roam
  :ensure t
  :defer 2
  :config
  :hook (after-init . org-mode)
  )

(use-package org-roam-ui
  :ensure t
  :defer 2
  :config
  :after (org-roam)
  )
