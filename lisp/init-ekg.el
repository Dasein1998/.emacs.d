(provide 'init-ekg)
(use-package ekg
  :ensure t
  :bind (([f11] . ekg-capture)))
  :defer 2

(use-package emacsql-sqlite
  :ensure t
  :defer 2
 )
(use-package triples
  :ensure t
  :defer 2
  )
