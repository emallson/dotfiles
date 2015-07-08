(require 'init-el-get)
;; clojure stuff
(add-to-list 'modules:el-get-packages 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.cljs?.hl\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

;;; indentation for compojure
(eval-after-load #'clojure-mode
  '(progn
    (define-clojure-indent
      (defroutes 'defun)
      (GET 2)
      (POST 2)
      (PUT 2)
      (DELETE 2)
      (HEAD 2)
      (ANY 2)
      (context 2)
      (loop-tpl 2)
      (page 'defun)
      (let-realised 'defun)
      (when-realised 'defun)
      (waitp 'defun)
      (ann-record 'defun)
      (db-do-commands 'defun))
    (define-key clojure-mode-map (kbd "RET") 'paredit-newline)))

(add-to-list 'modules:el-get-packages 'cider)

(eval-after-load #'cider-mode
  '(progn
     (add-hook 'cider-mode-hook #'cider-turn-on-eldoc-mode)
     (setq nrepl-hide-special-buffers t)))

(provide 'init-clojure)
