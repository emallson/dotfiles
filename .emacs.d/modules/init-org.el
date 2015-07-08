;; org mode
(add-to-list 'modules:el-get-packages 'org-mode)

(defun setup-org-keys ()
  (org-defkey org-mode-map (kbd "C-c s d") 'org-demote-subtree)
  (org-defkey org-mode-map (kbd "C-c s p") 'org-promote-subtree)
  (org-defkey org-mode-map (kbd "C-c d") 'org-do-demote)
  (org-defkey org-mode-map (kbd "C-c SPC") nil)
  (org-defkey org-mode-map (kbd "C-c a l") 'org-timeline)
  (org-defkey org-mode-map (kbd "C-c C-x t") 'org-set-tags)
  (org-defkey org-mode-map (kbd "C-x C-e") 'org-emphasize)
  (global-set-key (kbd "C-c a a") 'org-agenda-list)
  (global-set-key (kbd "C-c a t") 'org-todo-list)
  (global-set-key (kbd "C-c a m") 'org-tags-view))

(defun setup-org-hooks ()
  (add-hook 'org-mode-hook (lambda () (electric-indent-mode 0))))

(defun setup-org-clocking ()
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate))

(defun setup-org-capture ()
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (define-key global-map (kbd "C-c c") 'org-capture))

(eval-after-load "org"
  '(progn
     (setup-org-keys)
     (setup-org-hooks)
     (setup-org-clocking)
     (setup-org-capture)))

; use C-c ' to go back to org mode from tangled file.
(defun safe-enable-org-tangle-jump ()
  "Bind `org-babel-tangle-jump-to-org' unless in `org-src-mode'."
  (interactive)
  (unless (bound-and-true-p org-src-mode)
    (local-set-key (kbd "C-c '") 'org-babel-tangle-jump-to-org)))

(add-hook 'prog-mode-hook #'safe-enable-org-tangle-jump)

;; gnuplot - used by org mode
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)
(setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

(provide 'init-org)
