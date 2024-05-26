(let (;; temporarily increase `gc-cons-threshold' when loading to speed up startup.
      (gc-cons-threshold most-positive-fixnum)
      ;; Empty to avoid analyzing files when loading remote files.
      (file-name-handler-alist nil))
      ;(benchmark-init/activate)
      )
(tool-bar-mode -1)                           ; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(setq-default mode-line-format nil)          ; Prevent flashing of unstyled modeline at startup
(setq frame-inhibit-implied-resize t)        ;禁止frame缩放
(setq native-comp-jit-compilation nil)
