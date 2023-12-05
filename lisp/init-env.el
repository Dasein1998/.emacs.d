(provide 'init-env)
(setenv "PATH" (concat (getenv "PATH") ";" "C:\\Program Files\\Git\\usr\\bin"))
(setq xref-search-program
      (cond
       ((or (executable-find "ripgrep")
            (executable-find "rg"))
        'ripgrep)
       ((executable-find "ugrep")
        'ugrep)
       (t
        'grep)))
