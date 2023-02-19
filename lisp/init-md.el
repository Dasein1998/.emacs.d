(provide 'init-md)
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :config
  (setq markdown-command "multimarkdown")
  )
