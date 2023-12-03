(provide 'init-dashboard)
(use-package dashboard
:disabled t
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


(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
  )

(use-package flypy
  :ensure t
  :vc (flypy :url "https://github.com/Dasein1998/xhyx-emacs" :branch "master")
  :disabled t
  )
