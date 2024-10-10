(provide 'init-dashboard)
(use-package dashboard
  :ensure (:wait t)
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists) 
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize) 
  (add-hook 'window-size-change-functions #'dashboard-resize-on-hook 100)
  (add-hook 'window-setup-hook #'dashboard-resize-on-hook)
  
  (setq dashboard-banner-logo-title "You are what you do!") ;; 个性签名，随读者喜好设置
  (setq dashboard-projects-backend 'projectile) ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
  ;; (setq dashboard-startup-banner 'official) ;; 也可以自定义图片
  (setq dashboard-items '((recents  . 10)   ;; 显示多少个最近文件
			  (bookmarks . 5)  ;; 显示多少个最近书签
			  (projects . 5)
			  )) ;; 显示多少个最近项目
  )

(use-package benchmark-init
  :ensure (:wait t)
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
)


