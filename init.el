(defconst IS-WINDOWS (eq system-type 'windows-nt))
(defconst IS-LINUX (eq system-type 'gnu/linux))
;; windows-nt的编码问题
;;  (when (and (eq system-type 'windows-nt);;打开windows中的utf-8后的设置
;;             (eq w32-ansi-code-page 65001))
;;    (setq w32-system-coding-system 'utf-8)
;;    (setq file-name-coding-system 'gbk)
;;    (define-coding-system-alias 'cp65001 'utf-8))
(when (eq system-type 'windows-nt)
  (setq file-name-coding-system 'gbk))
(when (eq system-type 'darwin) ;; mac specific settings
    (setq mac-option-modifier 'alt)
    (setq mac-command-modifier 'meta)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
)
;; https://emacs-china.org/t/emacs-utf-8/21143/28?u=dasein

(if (display-graphic-p) ;; GUI mode
       (progn (tool-bar-mode -1)                           ;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
           (menu-bar-mode -1))                        ;; 关闭菜单栏
    ;; Terminal mode
    (progn (menu-bar-mode 1)
    (tool-bar-mode 1)))
(fset 'yes-or-no-p 'y-or-n-p)                ; yes or no 改为 y or n
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
(setq inhibit-splash-screen t)               ;关闭首页
(setq visible-bell t)                        ;避免Emacs在出错时发出声音
(setq mouse-yank-at-point t)
(blink-cursor-mode 0)                        ;避免光标闪烁
;(setq split-width-threshold 1)              ;强制左右分屏
;当大于两个buffer时，删除前一个。
(defadvice org-open-at-point (after my-org-open-at-point activate)
  (while (>  (count-windows) 2)
    (delete-window (cadr (window-list-1)))))

(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))));autosave in one dir

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (setopt custom-file "~/.emacs.d/custom.el")
;; (load custom-file t)
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))

(require 'package)
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
(when (< emacs-major-version 27)
  (package-initialize))
(setq
      use-package-always-ensure t            ;避免每个软件包都需要加 ":ensure t"
      ;; use-package-always-defer t            ;避免每个软件包都需要加 ":defer t"
      use-package-expand-minimally t
      vc-use-package-deactivate-advice t )

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(set-frame-parameter (selected-frame) 'buffer-predicate
		     (lambda (buf) (not (string-match-p "^*" (buffer-name buf)))));;only cycle through buffers whose name does not start with an *
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))


(cl-defun slot/vc-install (&key (fetcher "github") repo name rev backend)
  (let* ((url (format "https://%s.com/%s" fetcher repo))
         (iname (when name (intern name)))
         (pac-name (or iname (intern (file-name-base repo)))))
    (unless (package-installed-p pac-name)
      (package-vc-install url iname rev backend))))


(require 'init-env)
(require 'init-vertico)
(require 'init-fonts)
(require 'init-key)
(require 'init-company)
(require 'init-consult)
(require 'init-lazy)
(require 'init-lan)
(require 'init-note)
(require 'init-buildin)
(require 'init-my-mode)
(provide 'init)
