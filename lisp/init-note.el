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
  (add-to-list 'org-emphasis-alist
               '("*" (:foreground "red")
		 ))
  :bind
  ("C-i" . cape-elisp-block)
  )
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil))) ;;自动折行
(setq org-blank-before-new-entry '((heading . nil)
				   (plain-list-item . auto)) ;;取消新行前的空白
      )

(setq org-fontify-todo-headline nil)
(setq org-fontify-done-headline nil)
(defadvice org-schedule (after refresh-agenda activate)
  "Refresh org-agenda."
  (org-agenda-refresh))
;; Log time a task was set to DONE.
(setq org-log-done (quote time))

;; Don't log the time a task was rescheduled or redeadlined.
(setq org-log-redeadline nil)
(setq org-log-reschedule nil)
(setq org-read-date-prefer-future 'time)
;; use refile to help archive note just in one file
(setq org-refile-files
      '("~/org/note.org_archive"))
(setq org-refile-targets
      '((nil :maxlevel . 1)
        (org-refile-files :maxlevel . 1)))

;; Archive in one file
(setq org-archive-location "~/org/done.org_archive::datetree/")
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.1))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.08))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.06))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.04))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.02))))
  '(org-level-6 ((t (:inherit outline-6 :height 1.00))))
) ;;heading的字体大小
  (setq org-file-apps
    '(("\\.docx\\'" . default)
      ("\\.mm\\'" . default)
      ("\\.x?html?\\'" . default)
      ("\\.pdf\\'" . default)
      ("\\.png\\'" . default)
      (auto-mode . emacs)))

(setq org-tag-alist '(        ;;orgmode中快速给标题加标签
		      ("长" . ?c)
		      ("短" . ?d)
		      ("快" . ?k)
		      ("慢" . ?m)
		      ("问题" . ?w)
		      )
      )
;; 任务的状态
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "DOING(o)" "|" "DONE(d)" "CANCELLED(c)")))

(use-package consult-notes
  :commands (consult-notes
             consult-notes-search-in-all-notes
             )
  :config
  (setq consult-notes-file-dir-sources '(
					 ("note" ?n "~/org-roam")
					 )
	)
  (consult-notes-org-headings-mode)
  :bind
  ("M-s n" . consult-notes))

(use-package olivetti
  ;;:disabled t
  :bind ("<f8>" . olivetti-mode)
  :init
  (setq olivetti-body-width 0.85)
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
:ensure (:repo "toshism/org-super-links" :host github )
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

;;;Org-capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/org/life.org")
(setq org-capture-templates nil)
(add-to-list 'org-capture-templates
	     '("t" "Task"
	       entry
	       (file "~/org/inbox.org")
	       "* TODO [#B] %? %^g \n  %i  %a")
	     )
(add-to-list 'org-capture-templates
	     '("w" "Work journal" plain
	       (file+weektree "~/org/work.org")
	       "%<%T> %?"
	       :empty-lines 1)
	     )
(add-to-list 'org-capture-templates
	     '("f" "Flomo" entry (file "~/org/flomo.org")
	       ;;  "* %U - %^{heading}  \n %?\n"
	       "* %U \n %?\n"
	       :prepend t
	       )
	     )
(add-to-list 'org-capture-templates
	     '("d" "Deal" entry (file "~/org/deal.org")
	       ;;  "* %U - %^{heading}  \n %?\n"
	       "* %U \n %?\n"
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
(setq org-agenda-files '("~/org/inbox.org"))

;; https://www.cnblogs.com/Open_Source/archive/2011/07/17/2108747.html
(setq org-agenda-custom-commands
      '(
	("w" tags "Work"
         ((org-agenda-filter-by-tag "Work")))
	("f" tags "Life"
         ((org-agenda-filter-by-tag "Life")))
	("d" tags "Deal"
         ((org-agenda-filter-by-tag "Deal")))
	))



;;;从windows剪贴板插入图片
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

(use-package org-recur
  :hook ((org-mode . org-recur-mode)
         (org-agenda-mode . org-recur-agenda-mode))
  :config
  (define-key org-recur-mode-map (kbd "C-c d") 'org-recur-finish)
  ;; Rebind the 'd' key in org-agenda (default: `org-agenda-day-view').
  (define-key org-recur-agenda-mode-map (kbd "d") 'org-recur-finish)
  (define-key org-recur-agenda-mode-map (kbd "C-c d") 'org-recur-finish)
  (setq org-recur-finish-done t
        org-recur-finish-archive t))
;; Refresh org-agenda after rescheduling a task.
(defun org-agenda-refresh ()
  "Refresh all `org-agenda' buffers."
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (derived-mode-p 'org-agenda-mode)
        (org-agenda-maybe-redo)))))

(use-package org-appear
  :ensure (:host github :repo "awth13/org-appear")
  :config
  (add-hook 'org-mode-hook 'org-appear-mode)
  (setq org-hide-emphasis-markers t)
  (setq org-appear-autoentities t)
  (setq org-appear-autolinks t)
  (setq org-appear-delay 1)
  )

;;hide properties
(defun org-hide-properties ()
  "Hide org headline's properties using overlay."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
            "^ *:PROPERTIES:\n\\( *:.+?:.*\n\\)+ *:END:\n" nil t)
      (overlay-put (make-overlay
                    (match-beginning 0) (match-end 0))
                   'display ""))))

(add-hook 'org-mode-hook #'org-hide-properties)

;;; some function
;;move headline to a single file
;;https://emacs.stackexchange.com/questions/22078/how-to-split-a-long-org-file-into-separate-org-files
(defun my/org-move-tree (buffer-file-name)
  "move the sub-tree which contains the point to a file,
and replace it with a link to the newly created file"
  (interactive "F")
  (org-mark-subtree)
  (let*
      ((title    (car (last (org-get-outline-path t))))
       (dir      (file-name-directory buffer-file-name))
       (filename (concat dir title ".org"))
       (content  (buffer-substring (region-beginning) (region-end))))
    (delete-region (region-beginning) (region-end))
    (insert (format "** [[file:%s][%s]]\n" filename title))
    (with-temp-buffer
      (insert content)
      (write-file filename))))

;;split one big org file to multi single org file by first headline
;;https://emacs.stackexchange.com/questions/66828/split-org-file-into-smaller-ones
(defun my/org-export-each-level-1-headline-to-org (&optional scope)
  (interactive)
  (org-map-entries
   (lambda ()
     (let* ((title (car (last (org-get-outline-path t))))
            (dir (file-name-directory buffer-file-name))
            (filename (concat dir title ".org"))
            content)
       (org-narrow-to-subtree)
       (setq content (buffer-substring-no-properties (point-min) (point-max)))
       (with-temp-buffer
         (insert content)
         (write-file filename))
       (widen)))
   "LEVEL=1" scope))

;;delete current buffer and
;; based on http://emacsredux.com/blog/2013/04/03/delete-file-and-buffer/
(defun my/delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
        (if (y-or-n-p (concat "Do you really want to delete file " filename " ?"))
            (progn
              (delete-file filename)
              (message "Deleted file %s." filename)
              (kill-buffer)))
      (message "Not a file visiting buffer!"))))
