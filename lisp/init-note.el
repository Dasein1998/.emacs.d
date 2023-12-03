(provide 'init-note)
(use-package org
:ensure nil
:defer t
:config
(setq org-modules nil)
(require 'org-tempo)
:bind
("C-i" . cape-elisp-block)

)
(use-package org-roam
  :defer t
  :disabled t
  :config
  (setq org-roam-dailies-directory "000-D/")
  (setq org-roam-dailies-capture-templates
       '(("d" "default" entry
          "* 9-10\n\n* 10-11\n\n* 11-13\n\n* 13-14\n\n* 14-15\n\n* 15-16\n\n* 16-17\n\n* 17-18\n\n* 18-19\n\n* 19-20\n\n* 20-21\n\n* 21-22\n\n"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n")))
       )

      (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
      (org-roam-db-autosync-mode)
      (require 'org-roam-dailies)
  :hook (after-init . org-mode)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-ninsert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  )

(use-package org-roam-ui
  :defer t
  :config
  :after (org-roam)
  )
(use-package consult-org-roam
   :after org-roam
   :init
   (require 'consult-org-roam)
   ;; Activate the minor mode
   (consult-org-roam-mode 1)
   :custom
   ;; Use `ripgrep' for searching with `consult-org-roam-search'
   (consult-org-roam-grep-func #'consult-ripgrep)
   ;; Configure a custom narrow key for `consult-buffer'
   (consult-org-roam-buffer-narrow-key ?r)
   ;; Display org-roam buffers right after non-org-roam buffers
   ;; in consult-buffer (and not down at the bottom)
   (consult-org-roam-buffer-after-buffers t)
   :config
   ;; Eventually suppress previewing for certain functions
   (consult-customize
    consult-org-roam-forward-links
    :preview-key "M-.")
   :bind
   ;; Define some convenient keybindings as an addition
   ("C-c n e" . consult-org-roam-file-find)
   ("C-c n b" . consult-org-roam-backlinks)
   ("C-c n l" . consult-org-roam-forward-links)
   ("C-c n r" . consult-org-roam-search))



(use-package org-modern
  :after org
  :config
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
  )
(use-package denote
  :config
  ;; Remember to check the doc strings of those variables.
  (setq denote-directory (expand-file-name "~/org-roam/")
	  denote-journal-home (expand-file-name "000-D" denote-directory)
    denote-note-home (expand-file-name "001-pages/" denote-directory)
    denote-known-keywords '("daily" "temp")
    denote-infer-keywords t
    denote-sort-keywords t
    denote-file-type nil ; Org is the default, set others here
    denote-prompts '(title keywords)
    denote-excluded-directories-regexp nil
    denote-excluded-keywords-regexp nil
;; Pick dates, where relevant, with Org's advanced interface:
    denote-date-prompt-use-org-read-date t
;; Read this manual for how to specify `denote-templates'.  We do not
;; include an example here to avoid potential confusion.
    denote-date-format nil; read doc string
;; By default, we do not show the context of links.  We just display
;; file names.  This provides a more informative view.
    denote-backlinks-show-context t)
;; Also see `denote-link-backlinks-display-buffer-action' which is a bit
;; advanced.
;; If you use Markdown or plain text files (Org renders links as buttons
;; right away)
(add-hook 'find-file-hook #'denote-link-buttonize-buffer)
;; We use different ways to specify a path for demo purposes.
(setq denote-dired-directories
      (list denote-directory
            (thread-last denote-directory (expand-file-name "assets"))
            (expand-file-name "~/org-roam/assets"))
          )

(setq denote-templates
      `((daily . "* 9-11\n\n* 11-13\n\n* 13-17\n\n* 17-21")
        (memo . ,(concat "* Some heading"
                         "\n\n"
                         "* Another heading"
                         "\n\n"))))

;; Generic (great if you rename files Denote-style in lots of places):
(add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR if only want it in `denote-dired-directories':
;;(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)


;; Automatically rename Denote buffers using the `denote-rename-buffer-format'.
(denote-rename-buffer-mode 1)

;; Denote DOES NOT define any key bindings.  This is for the user to
;; decide.  For example:
(let ((map global-map))
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n c") #'denote-region) ; "contents" mnemonic
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n d") #'denote-date)
  (define-key map (kbd "C-c n z") #'denote-signature) ; "zettelkasten" mnemonic
  (define-key map (kbd "C-c n s") #'denote-subdirectory)
  (define-key map (kbd "C-c n t") #'denote-template)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-add-links)
  (define-key map (kbd "C-c n b") #'denote-backlinks)
  (define-key map (kbd "C-c n f f") #'denote-find-link)
  (define-key map (kbd "C-c n f b") #'denote-find-backlink)
  ;; Note that `denote-rename-file' can work from any context, not just
  ;; Dired bufffers.  That is why we bind it here to the `global-map'.
  (define-key map (kbd "C-c n r") #'denote-rename-file)
  (define-key map (kbd "C-c n R") #'denote-rename-file-using-front-matter))

;; Key bindings specifically for Dired.
(let ((map dired-mode-map))
  (define-key map (kbd "C-c C-d C-i") #'denote-link-dired-marked-notes)
  (define-key map (kbd "C-c C-d C-r") #'denote-dired-rename-files)
  (define-key map (kbd "C-c C-d C-k") #'denote-dired-rename-marked-files-with-keywords)
  (define-key map (kbd "C-c C-d C-R") #'denote-dired-rename-marked-files-using-front-matter))

(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))

;; Also check the commands `denote-link-after-creating',
;; `denote-link-or-create'.  You may want to bind them to keys as well.


;; If you want to have Denote commands available via a right click
;; context menu, use the following and then enable
;; `context-menu-mode'.
(add-hook 'context-menu-functions #'denote-context-menu)

(require 'denote-journal-extras)
(setq denote-journal-extras-directory denote-journal-home
      denote-journal-extras-title-format "%Y-%m-%d"
      denote-journal-extras-keyword "daily")

  (defun my-denote-note ()
     "Create a note to pages, need to provide a subdirectory title and tag"
    (interactive)
    (let ((denote-prompts '(subdirectory title keywords))
          )
      (call-interactively #'denote)))
)
(advice-add 'denote-journal-extras-new-entry :filter-return #'my-increase)


(use-package consult-notes
  :commands (consult-notes
             consult-notes-search-in-all-notes
             ;; if using org-roam
            ; consult-notes-org-roam-find-node
             ;consult-notes-org-roam-find-node-relation
             )
  :config
  (setq consult-notes-file-dir-sources '(("daily"  ?d  "~/org-roam/000-D/")
					 ("note" ?n "~/org-roam/001-pages/"))) ;; Set notes dir(s), see below
  ;; Set org-roam integration, denote integration, or org-heading integration e.g.:
  ;;If you have org files with many headings (say some subset of your agenda files, for example) that you would like to include in a consult-notes search, you can enable consult-notes-org-headings-mode and the headings for files you specify in consult-notes-org-headings-files will be included in consult-notes.
  ;(setq consult-notes-org-headings-files '("~/path/to/file1.org"
 ;                                          "~/path/to/file2.org"))
  ;(consult-notes-org-headings-mode)
  (when (locate-library "denote")
    (consult-notes-denote-mode))
  ;; search only for text files in denote dir
  (setq consult-notes-denote-files-function (function denote-directory-text-only-files))
  :bind
  ("M-s f" . consult-notes))

(use-package olivetti
  ;:diminish
  :bind ("<f8>" . olivetti-mode)
  :init
  (setq olivetti-body-width 0.618)
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

  (defun xs-toggle-olivetti-for-md ()
    "if current buffer is org and only one visible buffer
  enable olivetti mode"
    (if (and (eq (buffer-local-value 'major-mode (current-buffer)) 'markdown-mode)
	     (or (eq (length (window-list nil nil nil)) 1)
		 (window-at-side-p (frame-first-window) 'right))) ;; frame-first-window 的 mode 是 org-mode 并且没有右边 window
	(olivetti-mode 1)
      (olivetti-mode 0)
      (when (eq (buffer-local-value 'major-mode (current-buffer)) 'markdown-mode)
	(visual-line-mode 1))))
  (add-hook 'markdown-mode-hook #'xs-toggle-olivetti-for-md)
  (add-hook 'window-configuration-change-hook #'xs-toggle-olivetti-for-md)
  )

;;emacs中文在orgmode会无法高亮。需要添加相应的空格。
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
(use-package org-download
  :config
  (setq-default org-download-heading-lvl nil)
  (setq org-download-screenshot-method "irfanview /clippaste /convert=\"%s\"")
  (setq-default org-download-image-dir "~/org-roam/assets/")
        (add-hook 'dired-mode-hook 'org-download-enable)
  (add-hook 'org-mode-hook 'org-download-enable)
  (defun dummy-org-download-annotate-function (link)
    "")
    (setq org-download-annotate-function
      #'dummy-org-download-annotate-function)
)