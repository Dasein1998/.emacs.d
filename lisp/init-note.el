(provide 'init-note)
(setq font-lock-maximum-decoration 1)

(use-package quick-note
  :init (slot/vc-install :fetcher "github" :repo "Dasein1998/quick-note")
  :custom
  (quick-note-file "~/org-roam/archive/0v.txt")
  ;; 你也可以顺便在这里修改其他的自定义选项，比如时间格式：
  (quick-note-prefix-format "%Y%m%dT%H%M%S")
  ;; 直接在这里绑定快捷键
  :bind
  ("C-c n" . quick-note))
 
(use-package org
  :ensure nil
  :config
  (setq org-modules nil)
  (require 'org-tempo)
  (require 'org-protocol)
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
      '("~/org-roam/note.org_archive"))
(setq org-refile-targets
      '((nil :maxlevel . 1)
        (org-refile-files :maxlevel . 1)))

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

(global-set-key (kbd "C-c i") 'my/org-insert-image-from-clipboard)

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
(use-package writeroom-mode
  :bind ("<f6>" . writeroom-mode)
)

;;;从windows剪贴板插入图片
(defun my/org-insert-image-from-clipboard ()
  "Insert an image from the clipboard into the current org buffer."
  (interactive)
  (let* ((current-dir (file-name-directory buffer-file-name))
	 (file-name-base (file-name-base buffer-file-name))
	 ;;(attach-dir (concat current-dir "assets/" file-name-base "/"))
	 (attach-dir "assets/")
	 (attach-dir-pic "./assets/")
	 (image-file (concat attach-dir (format-time-string "%Y%m%d%H%M%S") ".png"))
	 (image-file-pic (concat attach-dir-pic (format-time-string "%Y%m%d%H%M%S") ".png")));;相对路径
    ;; Ensure attach directory exists
    (unless (file-exists-p attach-dir)
      (make-directory attach-dir t))
    ;; Save the clipboard image to the attach directory
    (if (eq system-type 'windows-nt)
	(shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.Clipboard]::GetImage().Save('" image-file "', [System.Drawing.Imaging.ImageFormat]::Png)\""))
      (error "Unsupported OS")
      )
    ;; Insert the link to the image in the org file
    (insert (concat "[[file:" image-file-pic "]]"));;相对路径
    ;;(org-display-inline-images)
    )
  )
