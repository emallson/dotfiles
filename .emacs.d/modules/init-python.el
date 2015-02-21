;;; init-python.el --- Initialization for python programming
;;; Commentary:
;;;
;;; The folks on #emacs guided me towards elpy with jedi. Let's see how this goes.
;;;
;;; Code:

;;; Switch to the environment I spend most of my time working in.
(require 'nixos-env)

(add-hook 'python-mode-hook (lambda ()
                              (nixos-env-apply "cv-python" nil)))

;;; Install + Configure elpy
(package-require 'elpy)

(when (require 'elpy nil t)
  (elpy-enable))

(setq elpy-rpc-backend "jedi")

(add-hook 'elpy-mode-hook (lambda ()
                            (nixos-env-apply "cv-python" nil)))

(provide 'init-python)
;;; init-python.el ends here
