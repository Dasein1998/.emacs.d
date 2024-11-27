(provide 'init-company)

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  :init
  (setq corfu-auto t)
  (setq corfu-quit-at-boundary t)
  (global-corfu-mode)
  :config
  (corfu-popupinfo-mode)
  (corfu-history-mode 1)
  (savehist-mode 1)
  (add-to-list 'savehist-additional-variables 'corfu-history)
  )

(use-package emacs
  :ensure nil
  :config
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)
  (setq tab-always-indent 'complete)
  :custom
  (text-mode-ispell-word-completion nil)
  )

(use-package cape
  :ensure t
  :after corfu
  :bind (
	 ;; ("C-c p p" . completion-at-point) ;; capf
	 ;;      ("C-c p t" . complete-tag)        ;; etags
	 ;;      ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
	 ;;      ("C-c p h" . cape-history)
	 ;;      ("C-c p f" . cape-file)
	 ;;      ("C-c p k" . cape-keyword)
	 ;;      ("C-c p s" . cape-symbol)
	 ;;      ("C-c p a" . cape-abbrev)
	 ;;      ("C-c p i" . cape-ispell)
	 ;;      ("C-c p l" . cape-line)
	 ;;      ("C-c p w" . cape-dict)
	 ;;      ("C-c p \\" . cape-tex)
	 ;;      ("C-c p _" . cape-tex)
	 ;;      ("C-c p ^" . cape-tex)
	 ;;      ("C-c p &" . cape-sgml)
	 ;;      ("C-c p r" . cape-rfc1345)
	 )
  :config
  ;; Add `completion-at-point-functions', used by `completion-at-point'.

  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

  ;; Configure Tempel
(use-package tempel
  ;; :defer t
  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert))
  :config
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))
  (add-hook 'conf-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)
  (setq tempel-path "~/.emacs.d/templates")
  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
  ;; (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  ;; (global-tempel-abbrev-mode)
  )
(use-package tempel-collection
  :after (tempel))
