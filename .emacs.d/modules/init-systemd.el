;;; init-systemd.el --- Configuration to initialize systemd-related settings
;;;
;;; Commentary:
;;; This should (I think) just be setting .service files to use conf-unix-mode.
;;;
;;; Code:

(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-unix-mode))

(provide 'init-systemd)
;;; init-systemd.el ends here
