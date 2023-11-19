(provide 'init-elfeed)
(use-package elfeed
  :ensure t
  :defer t)
(setq elfeed-feeds
      '(("https://www.ruanyifeng.com/blog/atom.xml" tech)
      ("https://rssh-ub-fork-five.vercel.app/zhihu/people/activities/hasmart" zhihu)
      ))

(setf elfeed-curl-extra-arguments '("--socks5-hostname" "127.0.0.1:7891"))
(setq-default elfeed-search-filter "@3-month-ago" )
