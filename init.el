(let (;; temporarily increase `gc-cons-threshold' when loading to speed up startup.
      (gc-cons-threshold most-positive-fixnum)
      ;; Empty to avoid analyzing files when loading remote files.
      (file-name-handler-alist nil))
      ;(benchmark-init/activate)
)

(tool-bar-mode -1)                           ; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(setq inhibit-startup-message t)
;(setq confirm-kill-emacs #'yes-or-no-p)     ; 在关闭 Emacs 前询问是否确认关闭，防止误触
(electric-pair-mode t)                       ; 自动补全括号
(add-hook 'prog-mode-hook #'show-paren-mode) ; 编程模式下，光标在括号上时高亮另一个括号
(column-number-mode t)                       ; 在 Mode line 上显示列号
(global-auto-revert-mode t)                  ; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(delete-selection-mode t)                    ; 选中文本后输入文本会替换文本（更符合我们习惯了的其它编辑器的逻辑）
(setq make-backup-files nil)                 ; 关闭文件自动备份
(add-hook 'prog-mode-hook #'hs-minor-mode)   ; 编程模式下，可以折叠代码块
;(global-display-line-numbers-mode 1)         ; 在 Window 显示行号
(savehist-mode 1)                            ; （可选）打开 Buffer 历史记录保存
;(setq display-line-numbers-type 'relative)  ; （可选）显示相对行号
(setq-default cursor-type 'bar)              ;设置光标为竖线
(setq-default mode-line-format nil)          ; Prevent flashing of unstyled modeline at startup
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))));autosave in one dir

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file t)

(require 'package)
(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
(package-initialize)
(setq use-package-always-ensure t            ;避免每个软件包都需要加 ":ensure t"
 ;     use-package-always-defer t            ;避免每个软件包都需要加 ":defer t"
      use-package-expand-minimally t)
(when (not package-archive-contents)
	   (package-refresh-contents))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'process-coding-system-alist '("rg" utf-8 . gbk));;解决counsel-rg无法搜索中文的问题
;require 'init-dired)
(require 'init-vertico)
;(require 'init-dashboard)
(require 'init-fonts)
(require 'init-md)
(require 'init-key)
(require 'init-company)
(require 'init-project)
(require 'init-consult)
;(require 'init-ekg)
(require 'lazy-load)
(require 'on)
(require 'init-lan)
(require 'init-roam)
(require 'init-quelpa)
(require 'init-avy)
(require 'init-buildin)
;(require 'init-elfeed)
;(require 'init-hyperbole)
;(require 'init-ob)
(require 'init-embark)
(provide 'init)
