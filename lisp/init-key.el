(provide 'init-key)
;; (global-set-key (kbd "M-f") 'forward-char)
;; (global-set-key (kbd "M-b") 'backward-char)
; (global-unset-key (kbd "M-<"))
; (global-unset-key (kbd "M->"))
; (global-set-key (kbd "M-<") 'undo)
; (global-set-key (kbd "M->") 'undo-redo)

(defun my-init-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/"))
(use-package ace-window
  :ensure t
  :bind
  ("M-o" . ace-window)
  :config
  ;;(global-set-key (kbd "M-o") 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defvar aw-dispatch-alist
    '((?x aw-delete-window "Delete Window")
      (?m aw-swap-window "Swap Windows")
      (?M aw-move-window "Move Window")
      (?c aw-copy-window "Copy Window")
      (?j aw-switch-buffer-in-window "Select Buffer")
      (?n aw-flip-window)
      (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
      (?c aw-split-window-fair "Split Fair Window")
      (?v aw-split-window-vert "Split Vert Window")
      (?b aw-split-window-horz "Split Horz Window")
      (?o delete-other-windows "Delete Other Windows")
      (?? aw-show-dispatch-help))
    "List of actions for `aw-dispatch-default'.")
  )
(use-package marginalia
  :ensure t
  :hook
  (on-first-input . marginalia-mode)
  )

(use-package embark
  :ensure t
  :disabled t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  (setq embark-minimal-indicator nil)
                 )


(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package mwim
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))

(use-package which-key
  :hook
  (on-first-input . which-key-mode)
  )

(use-package hydra
  ;; :defer t
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
  ;; :defer t
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

(setq mouse-wheel-scroll-amount '(2 ((shift) . 1) ((control) . nil)))
(setq scroll-conservatively most-positive-fixnum)
(setq scroll-preserve-screen-position t)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-progressive-speed nil) ;;禁止emacs滚动加速

