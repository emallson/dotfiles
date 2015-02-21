;;; scheme.el --- Configuration to initialize scheme
;;;
;;; Commentary:
;;; Starting to attempt to modularize my config. This is the first step: a file
;;; to load my scheme config.
;;;
;;; Code:

(require 'nixos-env)

;;; install repl and highlighting stuff for racket/guile
(package-require 'geiser)
(package-require 'quack)

;;; paredit is mandatory!
(add-hook 'scheme-mode-hook 'enable-paredit-mode)

(add-hook 'scheme-mode-hook (lambda ()
                              (nixos-env-apply "l2p")))

(add-hook 'geiser-repl-mode-hook (lambda ()
                                   (nixos-env-apply "l2p")))

;;; enable nixos env

(provide 'init-scheme)
;;; scheme.el ends here
