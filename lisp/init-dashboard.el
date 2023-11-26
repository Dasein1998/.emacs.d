(provide 'init-dashboard)
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "You are what you do!") ;; 个性签名，随读者喜好设置
 ; (setq dashboard-projects-backend 'projectile) ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
  ;(setq dashboard-startup-banner 'official) ;; 也可以自定义图片
  (setq dashboard-items '((recents  . 10)   ;; 显示多少个最近文件
			  (bookmarks . 5)  ;; 显示多少个最近书签
			  ;(projects . 5)
        )) ;; 显示多少个最近项目
  (dashboard-setup-startup-hook))
(use-package sort-tab
  :ensure t
  :vc (sort-tab :url "https://github.com/manateelazycat/sort-tab" :branch "main")
  :config
  (sort-tab-mode 1)
  :bind
  ("M-1" . sort-tab-select-visible-tab)
  ("M-2" . sort-tab-select-visible-tab)
  )

(use-package auto-save
:ensure t
:vc (auto-save :url "https://github.com/manateelazycat/auto-save" :branch "master")
:config
(auto-save-enable)
(setq auto-save-silent t)   ; quietly save
(setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving

;;; custom predicates if you don't want auto save.
;;; disable auto save mode when current filetype is an gpg file.
(setq auto-save-disable-predicates
      '((lambda ()
      (string-suffix-p
      "gpg"
      (file-name-extension (buffer-name)) t))))
      )

(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
  )

(use-package flypy
  :ensure t
  :vc (flypy :url "https://github.com/Dasein1998/xhyx-emacs" :branch "master")
  :defer t
  )
