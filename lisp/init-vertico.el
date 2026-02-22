(provide 'init-vertico)
;; Enable vertico
(use-package vertico
  :config
  (vertico-mode)
  (vertico-mouse-mode)
    (setq vertico-count 20)
  )
(vertico-multiform-mode)
(setq vertico-multiform-commands
      '((consult-line buffer indexed)))
(setq vertico-multiform-categories
      '((file grid)
        (consult-line buffer)))

(use-package emacs
  :ensure nil
  :config
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
  (setq enable-recursive-minibuffers t))
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))