(provide 'init-org-roam)
;;https://gitee.com/mickey991/emacs-latex/blob/master/main.org
;;pacman -S mingw-w64-x86_64-emacs-pdf-tools-server
;;https://github.com/vedang/pdf-tools?tab=readme-ov-file#installing-pdf-tools
(use-package pdf-tools
  :ensure t
  :defer t
  :config
  (pdf-loader-install))

(use-package org-noter
  :ensure t
  :config
  ;;(setq org-noter-notes-search-path ("~/org-roam"))
  (setq org-noter-auto-save-last-location t) ;; 自动保存上次阅读位置
  :bind
  ("C-c n n" . org-noter) ;; 与 org-roam 配合
  )



(use-package cdlatex
  :after tex ; cdlatex 需要 auctex 中的 texmathp.el
  :defer t
  :quelpa (cdlatex :fetcher github :repo "cdominik/cdlatex")
  :config
  ;; org-cdlatex-mode 中使用 cdlatex 的自动匹配括号, 并把 $...$ 换成 \( ... \)
  (defun my/insert-inline-OCDL ()
    (interactive)
    (insert "\\(")
    (save-excursion (insert "\\)" )))
  (defun my/insert-dollar-OCDL ()
    (interactive)
    (insert "$")
    (save-excursion (insert "$" )))
  (defun my/insert-bra-OCDL ()
    (interactive)
    (insert "(")
    (save-excursion (insert ")" )))
  (defun my/insert-sq-bra-OCDL ()
    (interactive)
    (insert "[")
    (save-excursion (insert "]" )))
  (defun my/insert-curly-bra-OCDL ()
    (interactive)
    (insert "{")
    (save-excursion (insert "}" )))
  (define-key org-cdlatex-mode-map (kbd "$") 'my/insert-inline-OCDL)
  (define-key org-cdlatex-mode-map (kbd "(") 'my/insert-bra-OCDL)
  (define-key org-cdlatex-mode-map (kbd "[") 'my/insert-square-bra-OCDL)
  (define-key org-cdlatex-mode-map (kbd "{") 'my/insert-curly-bra-OCDL)
  )


;; latex
(defun my/latex-hook ()
  (turn-on-cdlatex)
  (turn-on-reftex))

(use-package tex
  :ensure auctex
  :defer 3
  :custom
  (TeX-parse-self t) ; 自动解析 tex 文件
  (TeX-PDF-mode t)
  (TeX-DVI-via-PDFTeX t)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-method 'synctex)
  (TeX-view-program-selection '((output-pdf "PDF Tools"))) ; 使用 pdf-tools 预览 pdf
  (TeX-source-correlate-start-server t)
  :config
  (setq-default TeX-master t) ; 默认询问主文件
  (add-hook 'LaTeX-mode-hook 'my/latex-hook)
  (add-hook 'latex-mode-hook 'my/latex-hook)
  )


(use-package org
  :after tex
  :config
  (setq org-highlight-latex-and-related '(native latex entities)) ;; LaTeX 高亮设置
  (setq org-pretty-entities t) ;; LaTeX 代码的 prettify
  (setq org-pretty-entities-include-sub-superscripts nil) ;; 不隐藏 LaTeX 的上下标更容易编辑
  (setq my/latex-preview-scale 1.8)
  (setq org-format-latex-options
  	`(:foreground default :background default :scale ,my/latex-preview-scale :html-foreground "Black" :html-background "Transparent" :html-scale ,my/latex-preview-scale :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))) ;; 增大公式预览的图片大小
  (add-hook 'org-mode-hook #'org-cdlatex-mode) ;; 打开 cdlatex
  )

;;==============================
;; org 中 LaTeX 相关设置
;;==============================
;; 在 ~/texmf/tex/latex/ 下的 .sty 文件
;;(setq org-latex-packages-alist '(("" "mysymbol" t)))

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode))

;; 快速编译数学公式, 测试版
(use-package org-preview
  :quelpa (org-preview :fetcher github :repo "karthink/org-preview")
  :hook (org-mode . org-preview-mode)
  )
(use-package org-roam
  :ensure t
  :defer t
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  (add-to-list 'org-roam-capture-templates
	       '("c" "citar literature note" plain "%?"
		 :target (file+head "%(expand-file-name citar-org-roam-subdir org-roam-directory)/${citar-citekey}.org"
				    "#+title: Notes on: ${citar-title}\n#+subtitle: ${citar-author}, ${citar-date}")
		 :unnarrowed t))
  (setq citar-org-roam-capture-template-key "c")
  )



;; 第一步: 告诉 Emacs 从哪里读取 Zotero 的信息
(setq zot_bib '("~/org-roam/reference.bib")
      zot_pdf "~/pdf" ; Zotero 的 ZotFile 同步文件夹
      org_refs '("~/org-roam/reference/") ) ; 自定义的 org-roam 文献笔记目录

;; 第二步: 让 citar 读取 Zotero 的信息

;;;citar in org-mode
(use-package citar
  :demand t
  :defer t
  :custom
  (citar-bibliography zot_bib)
  (citar-open-entry-function #'citar-open-entry-in-zotero)
  (citar-notes-paths org_refs)
  ;; optional: org-cite-insert is also bound to C-c C-x C-@
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  :bind
  (:map org-mode-map :package org ("C-c b" . #'org-cite-insert))
  :init
  (setq org-cite-insert-processor 'citar
	org-cite-follow-processor 'citar
	org-cite-activate-processor 'citar)
  :config
  (setq citar-open-resources '(:files :links))
  )
(use-package citar-embark
  :ensure t
  :after citar embark
  :no-require t
  :config (citar-embark-mode)
  )

(setq citar-templates
      '((main . " ${date year issued:4} ${title:48} ${author editor:30%sn}")
        (suffix . " ${=key= id:15} ${=type=:12} ${tags keywords:*}")
        (preview . "${author editor:%etal} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
        (note . "Notes on ${author editor:%etal}, ${title}")))
(defun my/citar-open-entry-by-citekey ()
  "open citekey at point"
  (interactive)
  (citar-open-entry (thing-at-point 'word))
  )


(use-package citar-org-roam
  :diminish
  :after (citar org-roam)
  :config (citar-org-roam-mode)
  (setq citar-org-roam-subdir '("~/org-roam/reference/"))
  )

(setq citar-org-roam-template-fields
      '((:citar-citekey "key")
        (:citar-title "title")
        (:citar-author "author" "editor")
        (:citar-date "date" "year" "issued")
        (:citar-pages "pages")
        (:citar-type "=type="))   )

(defun citar-add-org-noter-document-property(key &optional entry)
  "Set various properties PROPERTIES drawer when new Citar note is created."
  (interactive)
  (let* ((file-list-temp (list (citar--select-resource key :files t)))
	 (file-path-temp (alist-get 'file file-list-temp))
	 (cite-author (cdr (citar-get-field-with-value'(author) key)))
	 (cite-url (cdr (citar-get-field-with-value '(url) key))) )

    (org-set-property "NOTER_DOCUMENT" file-path-temp)
    (org-set-property "Custom_ID" key)
    (org-set-property "AUTHOR" cite-author)
    (org-set-property "URL"    cite-url)
    (org-roam-ref-add (concat "@" Key))
    (org-id-get-create) )
  )

(advice-add 'citar-create-note :after #'citar-add-org-noter-document-property)

(setq org-noter-notes-search-path '("~/org-roam/reference" "~/org-roam" "~/org-roam/reference"))
