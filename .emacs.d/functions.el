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

;;; functions.el ends here
