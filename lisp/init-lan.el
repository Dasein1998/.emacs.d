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
  )
