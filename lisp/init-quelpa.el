(provide 'init-quelpa)
(use-package quelpa
  :commands quelpa
  :custom
  (quelpa-git-clone-depth 1)
  (quelpa-self-upgrade-p nil)
  (quelpa-update-melpa-p nil)
  (quelpa-checkout-melpa-p nil)
)

(quelpa '(pyim-humadict :fetcher github :repo "Dasein1998/huma_pyim"))