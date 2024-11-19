(provide 'init-key)
;; (global-set-key (kbd "M-f") 'forward-char)
;; (global-set-key (kbd "M-b") 'backward-char)
(defun my-init-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/"))

(use-package mwim
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))

(use-package which-key
  :hook
  (on-first-input . which-key-mode)
  )

(use-package hydra
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
  :defer t
  :after hydra)

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package doom-modeline
  :ensure t
  :hook (on-first-file . doom-modeline-mode)
  :config
  (setq doom-modeline-buffer-state-icon nil)
  (setq doom-modeline-buffer-modification-icon nil)
  )

(use-package workgroups2
  :ensure t
  :init
  (workgroups-mode 1)
  )

(use-package newcomment
  :ensure nil
  :bind ([remap comment-dwim] . #'comment-or-uncomment)
  :config
  (defun comment-or-uncomment ()
    (interactive)
    (if (region-active-p)
        (comment-or-uncomment-region (region-beginning) (region-end))
      (if (save-excursion
            (beginning-of-line)
            (looking-at "\\s-*$"))
          (call-interactively 'comment-dwim)
        (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))
  :custom
  (comment-auto-fill-only-comments t)
  )

(use-package helpful
  :ensure t
  :bind
  ("C-h f" . helpful-callable)
  ("C-h v" . helpful-variable)
  ("C-h k" . helpful-key)
  ("C-h x" . helpful-command)
  ("C-c C-d" . helpful-at-point)
  ("C-h F" . helpful-function)
  )
