(provide 'init-consult)
(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-s r" . consult-ripgrep)
         ("<f5>" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s M-o" . consult-recent-file)
         ;; Isearch integration
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-r" . consult-history)                ;; orig. previous-matching-history-element
         )
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :config
  (if sys/win32p
    (progn
      (add-to-list 'process-coding-system-alist '("rg" utf-8 . gbk));;解决counslt-rg无法搜索中文的问题，开启默认utf-8后就不需要了。
      (add-to-list 'process-coding-system-alist '("es" gbk . gbk))
      (add-to-list 'process-coding-system-alist '("explorer" gbk . gbk))
      (setq consult-locate-args (encode-coding-string "es.exe -i -p -r" 'gbk))))
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  (setq xref-search-program
  	(cond
  	 ((or (executable-find "ripgrep")
              (executable-find "rg"))
          'ripgrep)
  	 ((executable-find "ugrep")
          'ugrep)
  	 (t
          'grep)))
  :config
  (setq consult-async-min-input 2)
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"
  (consult-customize
 consult-ripgrep consult-git-grep consult-grep
 consult-xref
 consult--source-bookmark consult--source-file-register
 consult--source-recent-file consult--source-project-recent-file
 :preview-key "M-.")            ;; Option 2: Manual preview
  )
(global-set-key (kbd "C-s")'consult-line-multi)