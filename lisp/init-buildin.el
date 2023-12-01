(provide 'init-buildin)
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))
(use-package whitespace
  :ensure nil
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
     lines-tail       ; lines go beyond `fill-column'
     space-before-tab ; spaces before tab
   ;  trailing         ; trailing blanks
     tabs             ; tabs (show by face)
     tab-mark         ; tabs (show by symbol)
     )))

(add-hook 'emacs-startup-hook
          (lambda ()
            (let ( (mgs-list '("You are what you do."
                                "Déjà vu!")) )
              (message (nth (random (length mgs-list)) mgs-list)))))
