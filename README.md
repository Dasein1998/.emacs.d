# .emacs.d
depends:
1. librime
2. rg
3. Windows: 'scoop install coreutils fd poppler imagemagick unzip'
4. pacman -S fd poppler ffmpegthumbnailer mediainfo imagemagick tar unzip

## librime
for Windows

``` powershell
scoop install gcc
scoop bucket add wsw0108 https://github.com/wsw0108/scoop-bucket.git
scoop install librime
scoop install ripgrep
```

for Arch

``` shell
sudo pacman -S librime
```


# Reference
[专业 Emacs 入门教程 - 知乎](https://www.zhihu.com/column/c_1440829147212279808)

[Emacs 自力求生指南 ── 来写自己的配置吧 - Nayuki's Archive](https://nyk.ma/posts/emacs-write-your-own/#%E8%BE%93%E5%85%A5%E6%B3%95)

[jwiegley/use-package: A use-package declaration for simplifying your .emacs](https://github.com/jwiegley/use-package#installing-use-package)

[Org-mode 简明手册 open source博客园](https://www.cnblogs.com/Open_Source/archive/2011/07/17/2108747.html)

[emacs-newbie/introduction-to-builtin-modes.md at master · condy0919/emacs-newbie](https://github.com/condy0919/emacs-newbie/blob/master/introduction-to-builtin-modes.md)
