(provide 'init-ekg)
(use-package ekg
  :ensure t
  :bind (([f11] . ekg-capture)))
  :defer t

(use-package emacsql-sqlite
  :ensure t
  :defer t
 )
(use-package triples
  :ensure t
  :defer t
  )
