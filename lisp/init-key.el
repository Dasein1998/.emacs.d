(provide 'init-key)
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/"))

(use-package which-key
  :ensure t
  :hook
  (on-first-input . which-key-mode)
  )
(use-package avy
  :ensure t
  :bind
 ; (("M-j C-SPC" 、. avy-goto-char-timer))
  )
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)

(use-package hydra
  :ensure t
  :defer t)
(use-package use-package-hydra
  :ensure t
  :defer t
  :after hydra)
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

;; Key Modifiers
(cond
 ((eq system-type 'windows-nt)
  ;; make PC keyboard's Win key or other to type Super or Hyper
  ;; (setq w32-pass-lwindow-to-system nil)
  (setq w32-lwindow-modifier 'super     ; Left Windows key
        w32-apps-modifier 'hyper)       ; Menu/App key
  (w32-register-hot-key [s-t]))
 ((eq window-system 'mac)
  ;; Compatible with Emacs Mac port
  (setq mac-option-modifier 'meta
        mac-command-modifier 'super)
  (global-set-key [(super a)] #'mark-whole-buffer)
  (global-set-key [(super v)] #'yank)
  (global-set-key [(super c)] #'kill-ring-save)
  (global-set-key [(super s)] #'save-buffer)
  (global-set-key [(super l)] #'goto-line)
  (global-set-key [(super w)] #'delete-frame)
  (global-set-key [(super z)] #'undo)
  (global-set-key [(super e)] #'dirvish))
 )

(global-set-key (kbd "C-z") nil)

(use-package undo-tree
:ensure t
:config
(require 'undo-tree)
(global-undo-tree-mode 1))