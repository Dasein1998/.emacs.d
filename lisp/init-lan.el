(provide 'init-lan)
(use-package yaml-mode
  :mode ("\\.yaml\\'" . yaml-mode)
  )

(use-package json-mode
  :mode ("\\.json\\'" . json-mode)
  )

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :config
  (setq markdown-command "multimarkdown")
  )

(use-package fanyi
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
  (("M-g d" . fanyi-dwim2))
  :config
  (setq fanyi-auto-select nil)
  )

(use-package aggressive-indent
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  (css-mode . aggressive-indent-mode)
  )

(use-package eglot
  :ensure nil
  :defer t
  :demand t
  :config
  (add-to-list 'eglot-server-programs
	     '(python-mode . ("pyright-langserver" "--stdio"));; python -m pip install pyright 安装 Pyright
       )
  (add-hook 'python-mode 'eglot-ensure)
  )

(use-package treesit-fold
:defer t
:ensure (:repo "emacs-tree-sitter/treesit-fold" :host github)
)

;; pacman -S mingw-w64-ucrt-x86_64-gcc
(use-package treesit-auto
  :defer t
  :pin melpa
  :demand t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))