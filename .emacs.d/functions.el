;;; functions.el --- Summary:
;;; Commentary:
;;; Code:
(defun yank-to-x-clipboard ()
  "Yank the region to the X clipboard using xsel."
  (interactive)
  (if (region-active-p)
      (progn
        (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
        (message "Yanked region to clipboard!")
        (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))


(defun revert-all-buffers ()
  "Reverts all unmodified file buffers."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t t))))
  (message "Refreshed all unmodified file buffers."))

(defun package-require (package)
  "Download `PACKAGE' via `package.el' if it is not installed."
  (unless (package-installed-p package)
    (unless package-refreshed
      (package-refresh-contents))
    (package-install package)))
;;; functions.el ends here
