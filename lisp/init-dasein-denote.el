(provide 'init-dasein-denote)
(use-package denote
  :defer t
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n k" . denote-rename-file-keywords)
   ("C-c n s" . denote-silo-extras-open-or-create)
   ("C-c n o" . denote-open-or-create)
   )
  :config
  (setq denote-directory (expand-file-name "~/org-roam"))
  (setq denote-rename-confirmations nil) 
  (setq denote-file-type 'org)
  (denote-rename-buffer-mode 1)
  (require 'denote-silo-extras)
  (setq denote-silo-extras-directories
	`("~/org/"
	  "~/notes/")
	)
  )

(use-package citar-denote
:ensure(:repo "pprevos/citar-denote" :host github)
:after (citar denote)
;; :preface
;; (bind-key "C-c w n" #'citar-denote-open-note)
:custom
;; Package defaults
(citar-denote-file-type 'org)
(citar-denote-keyword "bib")
(citar-denote-signature nil)
(citar-denote-subdir nil)
(citar-denote-template nil)
(citar-denote-title-format "title")
(citar-denote-title-format-andstr "and")
(citar-denote-title-format-authors 1)
(citar-denote-use-bib-keywords nil)
:init
(citar-denote-mode)
;; Bind all available commands
:bind (("C-c w d" . citar-denote-dwim)
       ("C-c w e" . citar-denote-open-reference-entry)
       ("C-c w a" . citar-denote-add-citekey)
       ("C-c w k" . citar-denote-remove-citekey)
       ("C-c w r" . citar-denote-find-reference)
       ("C-c w l" . citar-denote-link-reference)
       ("C-c w f" . citar-denote-find-citation)
       ("C-c w x" . citar-denote-nocite)
       ("C-c w y" . citar-denote-cite-nocite)
       ("C-c w z" . citar-denote-nobib))
)
(defun dasein-denote-buffer-file-name (&optional buffer)
  "Save filename of BUFFER is visiting to kill-ring."
  (interactive)
  (kill-new "[[denote:" (message "%s" (dasein-denote-number-function (file-name-nondirectory (buffer-file-name buffer))))"][" (message "%s" (dasein-denote-title (file-name-nondirectory (buffer-file-name buffer)))) "]]"))

(defun dasein-denote-number-function (file-name)
  "匹配denote的编号。"
 (let ((string file-name)
      (regexp "^[0-9a-zA-Z]+"))
  (when (let ((case-fold-search 'ignore-case))
          (string-match regexp string))
    (match-string 0 string)))
 )

(defun dasein-denote-title (file-name)
  "匹配denote的标题。"
 (let ((string file-name)
      (regexp "--\\([[:alnum:][:nonascii:]-]*\\)"));参考denote里的denote-retrieve-filename-title
  (when (let ((case-fold-search 'ignore-case))
          (string-match regexp string))
    (match-string 1 string)))
 )
