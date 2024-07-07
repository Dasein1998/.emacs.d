(provide 'init-note)
(use-package org
  :ensure nil
  :config
  (setq org-modules nil)
  (require 'org-tempo)
  (setq org-src-fontify-natively t);;org内代码自动高亮
  (setq word-wrap-by-category t) ;;分词折行
  (require 'org-indent)
  ;;(setq org-startup-indented t)
  (setq org-yank-image-save-method "assets/");;orgmode中，yank media的保存位置
  :bind
  ("C-i" . cape-elisp-block)
  )
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil))) ;;自动折行
(setq org-blank-before-new-entry '((heading . nil)
				   (plain-list-item . auto)) ;;取消新行前的空白
  )
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.1))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.08))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.06))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.04))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.02))))
  '(org-level-6 ((t (:inherit outline-6 :height 1.00))))
) ;;heading的字体大小

(setq org-tag-alist '(        ;;orgmode中快速给标题加标签
		      ("长" . ?c)
		      ("短" . ?d)
		      ("快" . ?k)
		      ("慢" . ?m)
		      ("问题" . ?w)

		      )
      )
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
(use-package consult-notes
  :commands (consult-notes
             consult-notes-search-in-all-notes
             )
  :config
  (setq consult-notes-file-dir-sources '(
					 ;;("daily"  ?d  "~/")
					 ;;("note" ?n "~/)
					 )
	) ;; Set notes dir(s), see below
  ;; Set org-roam integration, denote integration, or org-heading integration e.g.:
  ;;If you have org files with many headings (say some subset of your agenda files, for example) that you would like to include in a consult-notes search, you can enable consult-notes-org-headings-mode and the headings for files you specify in consult-notes-org-headings-files will be included in consult-notes.
  ;;(setq consult-notes-org-headings-files '("~/path/to/file1.org"
  ;;"~/path/to/file2.org"))
  ;;(consult-notes-org-headings-mode)
  (when (locate-library "denote")
    (consult-notes-denote-mode))
  ;; search only for text files in denote dir
  (setq consult-notes-denote-files-function (function denote-directory-text-only-files))
  :bind
  ("M-s f" . consult-notes))

(use-package olivetti
  ;; :diminish
  ;;:disabled t
  :bind ("<f8>" . olivetti-mode)
  :init
  (setq olivetti-body-width 0.8)
  (defun xs-toggle-olivetti-for-org ()
    "if current buffer is org and only one visible buffer
  enable olivetti mode"
    (if (and (eq (buffer-local-value 'major-mode (current-buffer)) 'org-mode)
	     (or (eq (length (window-list nil nil nil)) 1)
		 (window-at-side-p (frame-first-window) 'right))) ;; frame-first-window 的 mode 是 org-mode 并且没有右边 window
	(olivetti-mode 1)
      (olivetti-mode 0)
      (when (eq (buffer-local-value 'major-mode (current-buffer)) 'org-mode)
	(visual-line-mode 1))))
  (add-hook 'org-mode-hook #'xs-toggle-olivetti-for-org)
  (add-hook 'window-configuration-change-hook #'xs-toggle-olivetti-for-org)
  )

  ;;emacs中文会导致orgmode无法正常高亮。需要添加相应的空格。
(font-lock-add-keywords 'org-mode
                        '(("\\cc\\( \\)[/+*_=~][^a-zA-Z0-9/+*_=~\n]+?[/+*_=~]\\( \\)?\\cc?"
                           (1 (prog1 () (compose-region (match-beginning 1) (match-end 1) ""))))
                          ("\\cc?\\( \\)?[/+*_=~][^a-zA-Z0-9/+*_=~\n]+?[/+*_=~]\\( \\)\\cc"
                           (2 (prog1 () (compose-region (match-beginning 2) (match-end 2) "")))))
                        'append)
(with-eval-after-load 'ox
  (defun eli-strip-ws-maybe (text _backend _info)
    (let* ((text (replace-regexp-in-string
                  "\\(\\cc\\) *\n *\\(\\cc\\)"
                  "\\1\\2" text));; remove whitespace from line break
           ;; remove whitespace from `org-emphasis-alist'
           (text (replace-regexp-in-string "\\(\\cc\\) \\(.*?\\) \\(\\cc\\)"
                                           "\\1\\2\\3" text))
           ;; restore whitespace between English words and Chinese words
           (text (replace-regexp-in-string "\\(\\cc\\)\\(\\(?:<[^>]+>\\)?[a-z0-9A-Z-]+\\(?:<[^>]+>\\)?\\)\\(\\cc\\)"
                                           "\\1 \\2 \\3" text)))
      text))
  (add-to-list 'org-export-filter-paragraph-functions #'eli-strip-ws-maybe))

;;; org-super-links
(use-package org-super-links
  :quelpa (org-super-links :repo "toshism/org-super-links" :fetcher github )
					;:after helm
  :config
  (require 'org-id)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
  :bind (("C-c s s" . org-super-links-link)
         ("C-c s l" . org-super-links-store-link)
         ("C-c s C-l" . org-super-links-insert-link)
         ("C-c s d" . org-super-links-quick-insert-drawer-link)
         ("C-c s i" . org-super-links-quick-insert-inline-link)
         ("C-c s C-d" . org-super-links-delete-link))
  )

;;;citar in org-mode
(use-package citar
  :demand t
  :defer t
  :custom
  (citar-bibliography '("~/bib/note.bib"))
  (citar-open-entry-function #'citar-open-entry-in-zotero)
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
(defun my-citar-open-entry-by-citekey ()
  "open citekey at point"
  (interactive)
  (citar-open-entry (thing-at-point 'word))
  )
;;;Org-capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/org/life.org")
(setq org-capture-templates nil)
(add-to-list 'org-capture-templates
	     '("t" "Work-task"
	       entry
	       (file+headline    "~/org/work.org" "Tasks")
	       "*** TODO %?\n  %i  %a")
	     )
(add-to-list 'org-capture-templates
	     '("w" "Work journal" plain
	       (file+weektree "~/org/work.org")
	       "%<%T> %?"
	       :empty-lines 1)
	     )
(add-to-list 'org-capture-templates
	     '("f" "Flomo" entry (file "~/org/flomo.org")
	       "* %U - %^{heading}  \n %?\n"
	       :prepend t
	       )
	     )
(add-to-list 'org-capture-templates
	     '("j" "Journal" plain
	       (file+datetree "~/org/life.org")
	       "%<%T> %?"
	       :empty-lines 1
	       )
	     )
(global-set-key "\C-ca" 'org-agenda)
(setq org-agenda-files '("~/org/work.org"
			 "~/org/life.org"
			 ))

;;;从剪贴板插入图片
(defun org-insert-image-from-clipboard ()
  "Insert an image from the clipboard into the current org buffer."
  (interactive)
  (let* ((current-dir (file-name-directory buffer-file-name))
	 (file-name-base (file-name-base buffer-file-name))
	 ;;(attach-dir (concat current-dir "assets/" file-name-base "/"))
	 (attach-dir (concat "assets/" file-name-base "/"))
	 (image-file (concat attach-dir (format-time-string "%Y%m%d%H%M%S") ".png")))
    ;; Ensure attach directory exists
    (unless (file-exists-p attach-dir)
      (make-directory attach-dir t))
    ;; Save the clipboard image to the attach directory
    (if (eq system-type 'windows-nt)
	(shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.Clipboard]::GetImage().Save('" image-file "', [System.Drawing.Imaging.ImageFormat]::Png)\""))
      (error "Unsupported OS")
      )
    ;; Insert the link to the image in the org file
    (insert (concat "[[file:" image-file "]]"))
    ;;(org-display-inline-images)
    )
  )
(global-set-key (kbd "C-c i") 'org-insert-image-from-clipboard)
