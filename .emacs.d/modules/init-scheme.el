;;; scheme.el --- Configuration to initialize scheme
;;;
;;; Commentary:
;;; Starting to attempt to modularize my config. This is the first step: a file
;;; to load my scheme config.
;;;
;;; Code:

;;; install repl and highlighting stuff for racket/guile
(add-to-list 'modules:el-get-packages 'geiser)
(add-to-list 'modules:el-get-packages 'quack)

;;; paredit is mandatory!
(eval-after-load 'geiser-mode
  (progn
	(add-hook 'scheme-mode-hook #'enable-paredit-mode)
	(add-hook 'geiser-repl-mode-hook #'enable-paredit-mode)))

(provide 'init-scheme)
;;; scheme.el ends here
