(provide 'init-key)
;; (global-set-key (kbd "M-f") 'forward-char)
;; (global-set-key (kbd "M-b") 'backward-char)
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/"))
(use-package mwim
  :ensure t
  :defer t
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))

(use-package which-key
  :ensure t
  :diminish
  :hook
  (on-first-input . which-key-mode)
  )

(use-package hydra
  :ensure t
  :defer t
  :config
  (defhydra my/org-hydra (global-map "C-c o" :color pink :hint nil )
    ("k" org-previous-visible-heading "Back")
    ("j" org-next-visible-heading "Forward")
    ("h" org-do-promote "Promote or demote current heading")
    ("l" org-do-demote "Demote current heading")
    ("c" nil)
    ("s" consult-line "conSult-line")
    ("L" org-super-links-link "Link org tree")
    ("d" org-super-links-delete-link "Delete link")
    ("a" org-archive-subtree "Archive org subtree")
    ("w" widen "Widen buffer")
    ("i" org-narrow-to-subtree "go Into narrow buffer to current subtree")
    ("H" org-toggle-heading "plain list transfer Headline")
    ("r" org-refile "Refile entry to a different location")
    ("u" undo "undo")
    ("G" end-of-buffer "Go to end of buffer")
    )
  )

(use-package use-package-hydra
  :ensure t
  :after hydra)




(use-package burly
  :defer t
  :quelpa (burly :fetcher github :repo "alphapapa/burly.el")
  )

(use-package tabspaces
  :defer t
  ;;:hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup.
  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Default")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*"))
  (tabspaces-initialize-project-with-todo t)
  ;;(tabspaces-todo-file-name "project-todo.org")
  ;; sessions
  (tabspaces-session t)
					;(tabspaces-session-auto-restore t)
  )

(use-package expand-region
  :bind ("C-=" . er/expand-region))
