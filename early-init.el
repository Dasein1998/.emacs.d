(let (;; temporarily increase `gc-cons-threshold' when loading to speed up startup.
      (gc-cons-threshold most-positive-fixnum)
      ;; Empty to avoid analyzing files when loading remote files.
      (file-name-handler-alist nil))

      )
;;(tool-bar-mode -1)                           ;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
;;(menu-bar-mode -1)                        ;; 关闭菜单栏
(setq frame-inhibit-implied-resize t)        ;禁止frame缩放
;; (setq native-comp-jit-compilation nil)
(setq inhibit-splash-screen t)               ;关闭首页
;;(set-scroll-bar-mode nil)
;;(setq-default mode-line-format nil)          ; Prevent flashing of unstyled modeline at startup
;; Inhibit resizing Puremacs frame
(setq frame-inhibit-implied-resize t)
(setq warning-minimum-level :emergency)
;; To suppress flashing at startup
(setq-default inhibit-redisplay t
              inhibit-message t)
(add-hook 'window-setup-hook
          (lambda ()
            (setq-default inhibit-redisplay nil
                          inhibit-message nil)
            (redisplay)))
;; (setq initial-scratch-message
;; "
;; ;;   ____    __     ___ ____  ____   _  _
;; ;;  (  _ \\  /__\\   /__)( ___)(_  _) (\\ ( )
;; ;;   )(_) )/(__)\\  \\__\\ )__)  _)(_   )\\(
;; ;;  (____/(__)(__)(___/(____)(____)(_)_\\_)
;; ;;           You are what you do!
;; ;;             C-c c org-Capture
;; ;;                C-c a Agenda
;; ;;             C-c , org-Priority
;; ;;        C-c n o Denote-Open-or-create
;; ;;  C-c n s  Denote-silo-extras-open-or-create
;; ")

;;; https://github.com/jamescherti/minimal-emacs.d/blob/main/early-init.el
;;; Performance

;; Prefer loading newer compiled files
(setq load-prefer-newer t)

;; Increase how much is read from processes in a single chunk (default is 4kb).
(setq read-process-output-max (* 256 1024))  ; 256kb

;; Reduce rendering/line scan work by not rendering cursors or regions in
;; non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Disable warnings from the legacy advice API. They aren't useful.
(setq ad-redefinition-action 'accept)

;; Ignore warnings about "existing variables being aliased".
(setq warning-suppress-types '((defvaralias) (lexical-binding)))

;; Don't ping things that look like domain names.
(setq ffap-machine-p-known 'reject)

;; By default, Emacs "updates" its ui more often than it needs to
(setq idle-update-delay 1.0)

;; Font compacting can be very resource-intensive, especially when rendering
;; icon fonts on Windows. This will increase memory usage.
(setq inhibit-compacting-font-caches t)

;; Without this, Emacs will try to resize itself to a specific column size
(setq frame-inhibit-implied-resize t)

;; A second, case-insensitive pass over `auto-mode-alist' is time wasted.
;; No second pass of case-insensitive search over auto-mode-alist.
(setq auto-mode-case-fold nil)

;; Reduce *Message* noise at startup. An empty scratch buffer (or the
;; dashboard) is more than enough, and faster to display.
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name)
(setq initial-buffer-choice nil
      inhibit-startup-buffer-menu t
      inhibit-x-resources t)
;; Disable bidirectional text scanning for a modest performance boost.
(setq-default bidi-display-reordering 'left-to-right
            bidi-paragraph-direction 'left-to-right)

;; Give up some bidirectional functionality for slightly faster re-display.
(setq bidi-inhibit-bpa t)

;; Remove "For information about GNU Emacs..." message at startup
(advice-add #'display-startup-echo-area-message :override #'ignore)

;; Suppress the vanilla startup screen completely. We've disabled it with
;; `inhibit-startup-screen', but it would still initialize anyway.
(advice-add #'display-startup-screen :override #'ignore)


;; (setq package-enable-at-startup nil)
(setq initial-frame-alist
      (append initial-frame-alist
              '((left   . 900)
                (top    . 100)
                (width  . 100)
                (height . 50))))
