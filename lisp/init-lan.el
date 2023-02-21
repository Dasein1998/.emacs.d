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
