(provide 'init-quelpa)
(use-package quelpa
  :commands quelpa
  :custom
  (quelpa-git-clone-depth 1)
  (quelpa-self-upgrade-p nil)
  (quelpa-update-melpa-p nil)
  (quelpa-checkout-melpa-p nil)
)
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)
(quelpa '(pyim-humadict :fetcher github :repo "Dasein1998/huma_pyim"))
(use-package on
    :quelpa (on :repo "ajgrf/on.el" :fetcher github )
)
