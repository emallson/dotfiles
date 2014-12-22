;;; scheme.el --- Configuration to initialize scheme
;;;
;;; Commentary:
;;; Starting to attempt to modularize my config. This is the first step: a file
;;; to load my scheme config.
;;;
;;; Code:

;;; install repl and highlighting stuff for racket/guile
(package-require 'geiser)
(package-require 'quack)

;;; paredit is mandatory!
(add-hook 'scheme-mode-hook 'enable-paredit-mode)

(provide 'init-scheme)
;;; scheme.el ends here
