(let (;; temporarily increase `gc-cons-threshold' when loading to speed up startup.
      (gc-cons-threshold most-positive-fixnum)
      ;; Empty to avoid analyzing files when loading remote files.
      (file-name-handler-alist nil))

      )
(tool-bar-mode -1)                           ; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(setq frame-inhibit-implied-resize t)        ;禁止frame缩放
(setq native-comp-jit-compilation nil)
(setq inhibit-splash-screen t)               ;关闭首页
(setq-default mode-line-format nil)          ; Prevent flashing of unstyled modeline at startup
;; Inhibit resizing Puremacs frame
(setq frame-inhibit-implied-resize t)

;; To suppress flashing at startup
(setq-default inhibit-redisplay t
              inhibit-message t)
(add-hook 'window-setup-hook
          (lambda ()
            (setq-default inhibit-redisplay nil
                          inhibit-message nil)
            (redisplay)))
(setq initial-scratch-message ";;You are what you do! \n")