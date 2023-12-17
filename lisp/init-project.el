(provide 'init-project)
(use-package magit
  :defer t
  )

(use-package projectile
:defer t
:ensure t
:config
(projectile-mode 1)
)

(defun org-docs-insert-image-from-clipboard ()
    "Take a screenshot into a time stamped unique-named file in the
   same directory as the org-buffer and insert a link to this file."
    (interactive)
    (let*  ((attachments-dir (concat (projectile-project-root) "assets/"))
           (jpg-file-name (format-time-string "%Y%m%d_%H%M%S.jpg"))
           (jpg-path (concat attachments-dir jpg-file-name))
    (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('" jpg-path "',[System.Drawing.Imaging.ImageFormat]::Jpeg); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
    (insert (concat "[[file:" jpg-path "]]"))
    )))
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))
