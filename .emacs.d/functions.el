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

(defun org-extract-link ()
  "Extract the next link from Org markup."
  (interactive)
  (when (re-search-forward "\\[\\[\\(.+\\)\\]\\[.+\\]\\]" (point-max) t)
    (match-string-no-properties 1)))

(defun org-extract-links ()
  "Extract all links after current point from Org markup."
  (let ((link (org-extract-link)))
    (unless (null link)
      (cons link (org-extract-links--internal)))))

(defun org-extract-links-into-kill-ring ()
  "Extract all links after current point into kill ring."
  (interactive)
  (kill-new "")
  (dolist (link (org-extract-links))
    (kill-append (concat link (string ?\n)) nil)))

(defun unfill-paragraph ()
  "Undo `fill-paragraph'."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))
;;; functions.el ends here
