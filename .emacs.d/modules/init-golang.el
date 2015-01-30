;;; init-golang.el --- Configuration for Go programming
;;;
;;; Commentary:
;;;
;;; Code:

(package-require 'go-mode)
(package-require 'company-go)

(defun go-mode-enable-gofmt ()
  "Enable `gofmt-before-save' locally.
Intended for use in `go-mode'."
  (add-hook 'before-save-hook 'gofmt-before-save nil t))

(eval-after-load 'go-mode
  '(progn (add-hook 'go-mode-hook #'go-mode-enable-gofmt)
          (define-key go-mode-map (kbd "M-.") 'godef-jump)
          (set (make-local-variable 'compile-command)
               "go build -v && go test -v && go vet")))

;;; init-golang.el ends here
