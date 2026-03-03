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

(defun centaur-setup-fonts ()
  "Setup fonts."
  (when (display-graphic-p)
    ;; Set default font
    (cl-loop for font in '("LXGW WenKai Mono" "Sarasa Term SC Nerd" "Iosevka" "Cascadia Code" "Fira Code" "Jetbrains Mono" "SF Mono" "Hack" "Source Code Pro" "Menlo" "Monaco" "DejaVu Sans Mono" "Consolas")
             when (font-installed-p font)
             return (set-face-attribute 'default nil
                                        :family font
                                        :height (cond (sys/macp 140)
                                                      (sys/win32p 130)
                                                      (t 110))
                                        ))))
(centaur-setup-fonts)
(add-hook 'window-setup-hook #'centaur-setup-fonts)
(add-hook 'server-after-make-frame-hook #'centaur-setup-fonts)
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8)
(setq system-time-locale "C")

(use-package rainbow-delimiters
  :config
  (rainbow-delimiters-mode)
  :hook (prog-mode . rainbow-delimiters-mode)
  )

(use-package ef-themes
  :ensure t
  :config
  ;; All customisations here.
  (setq modus-themes-mixed-fonts t)
  (setq modus-themes-italic-constructs t)
  (modus-themes-load-theme 'ef-elea-dark))