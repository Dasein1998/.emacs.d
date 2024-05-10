(provide 'init-fonts)
(defconst sys/win32p
  (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(defconst sys/linuxp
  (eq system-type 'gnu/linux)
  "Are we running on a GNU/Linux system?")

(defconst sys/macp
  (eq system-type 'darwin)
  "Are we running on a Mac system?")


;; Font
(defun font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (find-font (font-spec :name font-name)))
;; Fonts
(defun centaur-setup-fonts ()
  "Setup fonts."
  (when (display-graphic-p)
    ;; Set default font
    (cl-loop for font in '("Sarasa Term SC Nerd" "Iosevka" "Cascadia Code" "Fira Code" "Jetbrains Mono"
                           "SF Mono" "Hack" "Source Code Pro" "Menlo"
                           "Monaco" "DejaVu Sans Mono" "Consolas")
             when (font-installed-p font)
             return (set-face-attribute 'default nil
                                        :family font
                                        :height (cond (sys/macp 100)
                                                      (sys/win32p 110)
                                                      (t 100))
                                          ))

    ;; Set mode-line font
    ;; (cl-loop for font in '("Menlo" "SF Pro Display" "Helvetica")
    ;;          when (font-installed-p font)
    ;;          return (progn
    ;;                   (set-face-attribute 'mode-line nil :family font :height 120)
    ;;                   (when (facep 'mode-line-active)
    ;;                     (set-face-attribute 'mode-line-active nil :family font :height 120))
    ;;                   (set-face-attribute 'mode-line-inactive nil :family font :height 120)))

    ;; Specify font for all unicode characters
    (cl-loop for font in '("Segoe UI Symbol" "Symbola" "Symbol")
             when (font-installed-p font)
             return (if (< emacs-major-version 27)
                        (set-fontset-font "fontset-default" 'unicode font nil 'prepend)
                      (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend)))

    ;; Emoji
    (cl-loop for font in '("Noto Color Emoji" "Apple Color Emoji" "Segoe UI Emoji")
             when (font-installed-p font)
             return (cond
                     ((< emacs-major-version 27)
                      (set-fontset-font "fontset-default" 'unicode font nil 'prepend))
                     ((< emacs-major-version 28)
                      (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend))
                     (t
                      (set-fontset-font t 'emoji (font-spec :family font) nil 'prepend))))

    ;; Specify font for Chinese characters
    (cl-loop for font in '("Sarasa Term SC Nerd" "LXGW WenKai Screen R" "WenQuanYi Micro Hei" "PingFang SC" "Microsoft Yahei" "STFangsong")
             when (font-installed-p font)
             return (progn
                      (setq face-font-rescale-alist `((,font . 1.3)))
                      (set-fontset-font t '(#x4e00 . #x9fff) (font-spec :family font))))))

(centaur-setup-fonts)
(add-hook 'window-setup-hook #'centaur-setup-fonts)
(add-hook 'server-after-make-frame-hook #'centaur-setup-fonts)


(use-package rainbow-delimiters
  :ensure t
  :config
  (rainbow-delimiters-mode)
  :hook (prog-mode . rainbow-delimiters-mode)
  )
(use-package rime
  :ensure t
  :disabled t
  :custom
  (default-input-method "rime"))

(use-package gcmh  ;gc优化
  :init
  (gcmh-mode))

(use-package doom-themes
  :ensure t
  :disabled t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one-light t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; USE "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8)
(setq system-time-locale "C")
(when (eq system-type 'windows-nt)
  (setq file-name-coding-system 'gbk))

(use-package pangu-spacing
  :config
  (global-pangu-spacing-mode 1)
  (add-hook 'org-mode-hook
           '(lambda ()
              (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)
	      ))
   (add-hook 'markdown-mode-hook
           '(lambda ()
              (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)))
    )
(use-package sis
  ;; :hook
  ;; enable the /context/ and /inline region/ mode for specific buffers
  ;; (((text-mode prog-mode) . sis-context-mode)
  ;;  ((text-mode prog-mode) . sis-inline-mode))

  :config
  (when (eq system-type 'gnu/linux)
  (setq sis-ism-lazyman-config "1" "2" 'fcitx5))
  ;(sis-ism-lazyman-config "1033" "2052" 'im-select)
  ;; enable the /cursor color/ mode
  (sis-global-cursor-color-mode t)
  ;; enable the /respect/ mode
  (sis-global-respect-mode t)
  ;; enable the /context/ mode for all buffers
  (sis-global-context-mode t)
  ;; enable the /inline english/ mode for all buffers
  (sis-global-inline-mode t)

  )
(use-package posframe
:ensure t
:disabled t
)



(use-package pyim
  :ensure t
  ;:disabled t
  :init
  (setq default-input-method "pyim")
  :config
  (require 'pyim-humadict)
  (pyim-humadict-enable)
  (pyim-default-scheme 'huma)
  (require 'pyim-cstring-utils)  
  ;(require 'popup)
  ;(setq pyim-page-tooltip 'popup)
  ;(require 'posframe)
  ;(setq pyim-page-tooltip 'posframe)

  ;; 显示 5 个候选词。
(setq pyim-page-length 5)
;; 金手指设置，可以将光标处的编码（比如：拼音字符串）转换为中文。
(global-set-key (kbd "M-j") 'pyim-convert-string-at-point)
(global-set-key (kbd "C-\\") 'toggle-input-method)
;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
(define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)
(pyim-isearch-mode 1)
(define-key pyim-mode-map ";"
  (lambda ()
    (interactive)
    (pyim-select-word-by-number 2)))
:bind
("M-f" . pyim-forward-word)
("M-b" . pyim-backward-word)
  )
