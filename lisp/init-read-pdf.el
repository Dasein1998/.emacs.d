(provide 'init-read-pdf)
;;https://gitee.com/mickey991/emacs-latex/blob/master/main.org
;;pacman -S mingw-w64-x86_64-emacs-pdf-tools-server
;;https://github.com/vedang/pdf-tools?tab=readme-ov-file#installing-pdf-tools
(use-package pdf-tools
  :ensure t)
(use-package org-noter
  :ensure t
  :config
  (setq org-noter-notes-search-path ("~/org-roam"))
  (setq org-noter-auto-save-last-location t) ;; 自动保存上次阅读位置
  :bind
  ("C-c n n" . org-noter) ;; 与 org-roam 配合
  )



(use-package cdlatex
  :after tex ; cdlatex 需要 auctex 中的 texmathp.el
  :quelpa (cdlatex :fetcher github :repo "cdominik/cdlatex")
  )


;; latex
(defun my/latex-hook ()
  (turn-on-cdlatex)
  (turn-on-reftex))

(use-package tex
  :ensure auctex
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
  (setq org-pretty-entities-include-sub-superscripts nil) ;; 不隐藏 LaTeX 的上下标更容易编
  ;; 辑
  (setq my/latex-preview-scale 1.8)
  (setq org-format-latex-options
  	`(:foreground default :background default :scale ,my/latex-preview-scale :html-foreground "Black" :html-background "Transparent" :html-scale ,my/latex-preview-scale :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))) ;; 增大公式预览的图片大小
  (add-hook 'org-mode-hook #'org-cdlatex-mode) ;; 打开 cdlatex
  )

;;==============================
;; org 中 LaTeX 相关设置
;;==============================

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


;; 在 ~/texmf/tex/latex/ 下的 .sty 文件
;;(setq org-latex-packages-alist '(("" "mysymbol" t)))

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode))

;; 快速编译数学公式, 测试版
(use-package org-preview
  :quelpa (org-preview :fetcher github :repo "karthink/org-preview")
  :hook (org-mode . org-preview-mode)
  )
