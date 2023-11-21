(provide 'init-roam)
(use-package org
:ensure nil
:defer t
:config
(setq org-modules nil)
(require 'org-tempo)
)
(use-package org-roam
  :defer t
  :config
  (setq org-roam-dailies-directory "000-D/")
  (setq org-roam-dailies-capture-templates
       '(("d" "default" entry
          "* 9-10\n\n* 10-11\n\n* 11-13\n\n* 13-14\n\n* 14-15\n\n* 15-16\n\n* 16-17\n\n* 17-18\n\n* 18-19\n\n* 19-20\n\n* 20-21\n\n* 21-22\n\n"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n")))
       )

      (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
      (org-roam-db-autosync-mode)
      (require 'org-roam-dailies)
  :hook (after-init . org-mode)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-ninsert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  )

(use-package org-roam-ui
  :defer t
  :config
  :after (org-roam)
  )
(use-package consult-org-roam
   :after org-roam
   :init
   (require 'consult-org-roam)
   ;; Activate the minor mode
   (consult-org-roam-mode 1)
   :custom
   ;; Use `ripgrep' for searching with `consult-org-roam-search'
   (consult-org-roam-grep-func #'consult-ripgrep)
   ;; Configure a custom narrow key for `consult-buffer'
   (consult-org-roam-buffer-narrow-key ?r)
   ;; Display org-roam buffers right after non-org-roam buffers
   ;; in consult-buffer (and not down at the bottom)
   (consult-org-roam-buffer-after-buffers t)
   :config
   ;; Eventually suppress previewing for certain functions
   (consult-customize
    consult-org-roam-forward-links
    :preview-key "M-.")
   :bind
   ;; Define some convenient keybindings as an addition
   ("C-c n e" . consult-org-roam-file-find)
   ("C-c n b" . consult-org-roam-backlinks)
   ("C-c n l" . consult-org-roam-forward-links)
   ("C-c n r" . consult-org-roam-search))

(use-package org-download
  :after org
  :config
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq-default org-download-image-dir "~/org-roam/assets")
  (setq org-download-timestamp t)
  )

(use-package org-modern
  :after org
  :config
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
  )

