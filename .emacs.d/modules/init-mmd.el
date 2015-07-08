;;; init-mmd.el -- Initialization for major-mode-dedication
;;;
;;; Commentary:
;;;
;;; Using this to dedicate a frame to mail, a frame to irc, etc.
;;;
;;; Code:

(require 'el-get)

(add-to-list 'el-get-sources
             '(:name major-mode-dedication
                     :type git
                     :url "git://github.com/tom-seddon/major-mode-dedication.git"
                     :features major-mode-dedication
                     :compile "major-mode-dedication.el"
                     :after (progn
                              (mmd-install))))

;; (defun mmd-setup-mail ()
;;   "Dedicate a window to mail stuff."
;;   (let* ((mail-frame (make-frame '((name . "Mail"))))
;;          (mail-window (frame-first-window mail-frame)))
;;     (mapcar (lambda (f)
;;               (mmd-add-major-mode-window-dedication
;;                f mail-window))
;;             '(mu4e-main-mode
;;               mu4e-headers-mode
;;               mu4e-view-mode
;;               mu4e-compose-mode))))

(add-to-list 'modules:el-get-packages 'major-mode-dedication)

(provide 'init-mmd)
;;; init-mmd.el ends here
