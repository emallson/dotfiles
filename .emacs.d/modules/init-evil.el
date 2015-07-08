;;; init-evil.el -- Initialization/Customization code for evil-mode
;;; Commentary:
;;;
;;; My evil config grows unboundedly.
;;;
;;; Code:

(add-to-list 'modules:el-get-packages 'evil)
(add-to-list 'modules:el-get-packages 'evil-numbers)

(defun evil-global-set-noninsert-key (key cmd)
  "Bind `KEY' to `CMD' in all non-insert evil states."
  (dolist (state '(normal motion visual))
    (evil-global-set-key state key cmd)))

(defun setup-evil ()
  (evil-mode 1)

  (evil-global-set-noninsert-key "e" #'evil-backward-char)
  (evil-global-set-noninsert-key "n" #'evil-forward-char)
  (evil-global-set-noninsert-key "s" #'evil-previous-line)
  (evil-global-set-noninsert-key "t" #'evil-next-line)
  (evil-global-set-noninsert-key "l" #'evil-find-char-to)
  (evil-global-set-noninsert-key "L" #'evil-find-char-to-backward)
  (evil-global-set-noninsert-key "r" #'evil-search-next)
  (evil-global-set-noninsert-key "x" #'helm-M-x)
  (evil-global-set-noninsert-key "c" #'org-capture)

  (evil-global-set-noninsert-key (kbd "M-a") 'evil-beginning-of-line)
  (evil-global-set-noninsert-key (kbd "M-o") 'evil-end-of-line)

  (evil-global-set-key 'insert (kbd "C-t") 'transpose-chars)

  (evil-define-key 'normal evil-paredit-mode-map "x" nil)

  (dolist (mode '(mu4e-main-mode
                  mu4e-headers-mode
                  mu4e-view-mode
                  woman-mode
                  help-mode
                  cider-stacktrace-mode
                  flycheck-error-list-mode
                  epa-info-mode
                  paradox-menu-mode
                  image-mode
                  emms-browser-mode))
    (add-to-list 'evil-emacs-state-modes mode))

  (add-to-list 'evil-insert-state-modes 'cider-repl-mode)

                                        ; evil-numbers
  (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)


                                        ; kill buffer with :k
  (evil-ex-define-cmd "k[ill]" #'kill-this-buffer)

                                        ; tangle buffer with :t
  (evil-ex-define-cmd "t[angle]" #'org-babel-tangle))

(provide 'init-evil)
;;; init-evil.el ends here
