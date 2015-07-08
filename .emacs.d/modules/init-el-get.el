;;; init-el-get.el -- Initialization code for el-get
;;;
;;; Commentary:
;;;
;;; I am going to transition over to el-get piece by piece. Currently, much of
;;; my config uses my own `PACKAGE-REQUIRE' at the moment. el-get is a much
;;; nicer, more general solution.
;;;
;;; Code:
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer (url-retrieve-synchronously
                        "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

(defvar modules:el-get-packages nil
  "List of packages required from the modules/ folder.")
(add-to-list 'modules:el-get-packages 'el-get)

(defun finalize-el-get (&optional packages)
  "Called at the end of configuration to initialize `PACKAGES'."
  (interactive)
  (if (null packages)
      (el-get 'sync modules:el-get-packages)
    (el-get 'sync packages)))

(provide 'init-el-get)
;;; init-el-get.el ends here
