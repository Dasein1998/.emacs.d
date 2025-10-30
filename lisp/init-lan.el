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
  