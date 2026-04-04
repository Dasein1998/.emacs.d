(provide 'init-buildin)
;; 记录了上次打开文件时光标停留在第几行、第几列
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))
;; 高亮当前行。
;; (use-package hl-line
;;   :ensure nil
;;   :hook (after-init . global-hl-line-mode))
;; 选中文本后，可直接输入，省去删除操作
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))
;; 保存历史访问过的文件
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :init
  (setq recentf-max-menu-items 99)
  (setq recentf-max-saved-items 99)
  ;; (setq initial-buffer-choice #'recentf-open-files)
  )
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :ensure nil
  :hook
  (on-first-input . savehist-mode))

;; 显示空白字符
(use-package whitespace
  :ensure nil
  :disabled t
  :hook (after-init . global-whitespace-mode) ;; 注意，这里是全局打开
  :config
  ;; Don't use different background for tabs.
  (face-spec-set 'whitespace-tab
                 '((t :background unspecified)))
  ;; Only use background and underline for long lines, so we can still have
  ;; syntax highlight.

  ;; For some reason use face-defface-spec as spec-type doesn't work.  My guess
  ;; is it's due to the variables with the same name as the faces in
  ;; whitespace.el.  Anyway, we have to manually set some attribute to
  ;; unspecified here.
  (face-spec-set 'whitespace-line
                 '((((background light))
                    :background "#d8d8d8" :foreground unspecified
                    :underline t :weight unspecified)
                   (t
                    :background "#404040" :foreground unspecified
                    :underline t :weight unspecified)))

  ;; Use softer visual cue for space before tabs.
  (face-spec-set 'whitespace-space-before-tab
                 '((((background light))
                    :background "#d8d8d8" :foreground "#de4da1")
                   (t
                    :inherit warning
                    :background "#404040" :foreground "#ee6aa7")))

  (setq
   whitespace-line-column nil
   whitespace-style
   '(face             ; visualize things below:
     empty            ; empty lines at beginning/end of buffer
					;     lines-tail       ; lines go beyond `fill-column'
     space-before-tab ; spaces before tab
					;  trailing         ; trailing blanks
     tabs             ; tabs (show by face)
     tab-mark         ; tabs (show by symbol)
     )))

(use-package emacs
:ensure nil
:config
(setq tooltip-delay 3) ;;鼠标放上去3秒后触发tooltip
(setq use-system-tooltips nil))

(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 3          ;; 距离窗口边缘 3 行时就开始滚动
      scroll-preserve-screen-position t) ;; 翻页后保持光标在屏幕相对位置

;; (use-package cua-base
;;   :ensure nil ; 内置包无需下载
;;   :hook ((text-mode . cua-mode)
;;          (markdown-mode . cua-mode)
;;          (org-mode . cua-mode))
;;   :bind
;;   ("C-z" . undo-only) 
;;   ("C-y" . undo-redo)
;;   ("C-S-z" . undo-redo)
;;   :config
;; ;;   (setq cua-enable-cua-keys t)    ;; 开启 C-c, C-v, C-x, C-z
;;   (setq cua-highlight-region-shift-only nil) ;; 减少对选区高亮的额外计算
;;   ;; (setq cua-rectangle-mark-key nil) ;; 彻底禁用矩形标记键（通常是回车或 C-RET）

;; ;; ;; 强制 CUA 只处理按键，不干预底层的滚动和重绘逻辑
;; ;;   (setq cua-auto-tabify-rectangles nil)
;; ;;   (setq cua-draw-rectangle-lines nil)
;;   )
;;   (setq redisplay-dont-pause t) ; 即使有输入也不停止重绘（防止画面撕裂导致的感官卡顿）
;; (setq fast-but-imprecise-imaging t) ; 加速图像和复杂字符渲染，牺牲极小精度
;; (setq inhibit-compacting-font-caches t) ; 缓存字体，不要频繁回收字体内存（内存换速度）
;; (with-eval-after-load 'cua-base
;;   (define-key cua--keymap [remap scroll-up-command] nil)
;;   (define-key cua--keymap [remap scroll-down-command] nil)
;;   ;; 或者直接强制全局鼠标滚轮使用原生函数
;;   (global-set-key [mouse-4] 'scroll-down-line)
;;   (global-set-key [mouse-5] 'scroll-up-line))