(provide 'init-lan)
(use-package yaml-mode
  :defer 2
  :ensure t
  :mode ("\\.yaml\\'" . yaml-mode)
  )
(use-package json-mode
  :ensure t
  :defer 2
  :mode ("\\.json\\'" . json-mode)
  )
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :config
  (setq markdown-command "multimarkdown")
  )
(use-package fanyi
  :ensure t
  :defer t
  :custom
  (fanyi-providers '(;; 海词
                     fanyi-haici-provider
                     ;; 有道同义词词典
                     fanyi-youdao-thesaurus-provider
                     ;; Etymonline
                     fanyi-etymon-provider
                     ;; Longman
                     fanyi-longman-provider))
  :bind
  (("C-c C-t" . fanyi-dwim2))
  )

(use-package aggressive-indent
  :ensure t
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  (css-mode . aggressive-indent-mode)
  )
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs
	     '(python-mode . ("pyright-langserver" "--stdio"));; python -m pip install pyright 安装 Pyright
       )
  (add-hook 'python-mode 'eglot-ensure)
  )