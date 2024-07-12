(provide 'init-key)
;; (global-set-key (kbd "M-f") 'forward-char)
;; (global-set-key (kbd "M-b") 'backward-char)
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/"))
(use-package mwim
  :ensure t
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))

(use-package which-key
  :ensure t
  :hook
  (on-first-input . which-key-mode)
  )

(use-package hydra
  :ensure t
  )

(use-package use-package-hydra
  :ensure t
  :after hydra)

(defhydra my-org-hydra (global-map "C-c o" :color pink :hint nil )
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

(use-package keyfreq
  :ensure t
  :defer t
  :config
  (keyfreq-mode)
  (keyfreq-autosave-mode)
  )
(setq keyfreq-excluded-commands
      '(self-insert-command
        forward-char
        backward-char
        previous-line
        next-line))
(global-set-key (kbd "C-z") nil)

(use-package burly
  :defer t
  :quelpa (burly :fetcher github :repo "alphapapa/burly.el"))

(use-package tabspaces
  :hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup. 
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
    
(use-package meow
  :defer 2
  :ensure t
  :disabled t
  :config
  (defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))
   (meow-setup)
  (meow-global-mode 1))
  ;;meow配合sis，实现自动切换
  (defvar meow-leaving-insert-mode-hook nil
    "Hook to run when leaving meow insert mode.")
  (defvar meow-entering-insert-mode-hook nil
    "Hook to run when entering meow insert mode.")
  (add-hook 'meow-insert-mode-hook
            (lambda ()
              (if meow-insert-mode
                (run-hooks 'meow-entering-insert-mode-hook)
              (run-hooks 'meow-leaving-insert-mode-hook))))
  (with-eval-after-load 'sis
    (add-hook 'meow-leaving-insert-mode-hook #'sis-set-english)
    (add-to-list 'sis-context-hooks 'meow-entering-insert-mode-hook))

(use-package expand-region
  :bind ("C-=" . er/expand-region))
