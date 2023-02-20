(provide 'init-roam)
(use-package org-roam
  :ensure t
  :config
  :hook (after-init . org-mode)
  )

(use-package org-roam-ui
  :ensure t
  :config
  :after (org-roam)
  )
