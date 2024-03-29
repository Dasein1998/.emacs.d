(provide 'init-dasein-denote)

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
