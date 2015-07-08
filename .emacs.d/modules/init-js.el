(require 'init-el-get)

(add-to-list 'modules:el-get-packages 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-to-list 'el-get-sources
             '(:name nodejs-repl-emallson
                     :type git
                     :url "https://gist.github.com/0eae865bc99fc9639fac.git"
                     :depends (js2-mode)))

(add-to-list 'el-get-sources
             '(:name tern-emallson
                     :type github
                     :pkgname "emallson/tern"
                     :load-path "emacs"
                     :features tern))

(add-to-list 'modules:el-get-packages 'nodejs-repl-emallson)
(add-to-list 'modules:el-get-packages 'tern-emallson)

(defun js2--auto-replace-fat-arrow (&rest _args)
  (let ((fa-regexp "\\([[:word:][:digit:]_]+\\|(\\([[:word:][:digit:]_]+\\(, ?\\)?\\)*)\\) =>"))
    (when (and
           (equal (buffer-substring-no-properties
                   (- (point) 2) (point)) "=>")
           (re-search-backward fa-regexp (point-min) t))
      (replace-match "function\\1 {  }")
      (goto-char (- (point) 2)))))

(defun js2--auto-replace-or-insert-> ()
  (interactive)
  (insert ">")
  (undo-boundary)
  (js2--auto-replace-fat-arrow))

(eval-after-load "js2-mode"
  '(progn
     (define-key js2-mode-map (kbd "C-c M-j") #'nodejs-repl)
     (define-key js2-mode-map (kbd "C-x C-e") #'nodejs-repl-eval-dwim)
     (define-key js2-mode-map (kbd "C-x M-e") #'nodejs-repl-eval-function)
     (define-key js2-mode-map (kbd "C-x C-M-e") #'nodejs-repl-eval-buffer)
     (define-key js2-mode-map (kbd "M-RET") #'js2-line-break)
     (define-key js2-mode-map (kbd "RET") #'js2-line-break)
     (define-key js2-mode-map (kbd ">") #'js2--auto-replace-or-insert->)
     (add-hook 'js2-mode-hook #'subword-mode)
     (add-hook 'js2-mode-hook #'yas-minor-mode)
     (add-hook 'js2-mode-hook #'tern-mode)

     (defun js2-align-var-node (&optional node)
       "Align a multi-line var node (`NODE' or a parent)."
       (interactive)
       (let ((node (if (null node)
                       (js2-node-at-point)
                     node)))
         (if (js2-var-decl-node-p node)
             (align-regexp (js2-node-abs-pos node)
                           (js2-node-abs-end node)
                           "\\(\\s-*\\)=")
           (unless (null (js2-node-parent node))
             (js2-align-var-node (js2-node-parent node))))))

     (define-key js2-mode-map (kbd "C-c l") #'js2-align-var-node)))

(eval-after-load "tern"
  '(setq tern-command '("tern")))
(provide 'init-js)
