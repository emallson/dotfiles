;;; init.el --- Configuration for emacs
;;; Commentary:
;;; Writing this to shut up Checkdoc
;;; Code:

;;; no suspend-buffer
(global-set-key (kbd "C-z") nil)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/modules")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'cl)
(load-theme 'zenburn t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; make shift-insert behave like every other freaking program
(setq mouse-yank-at-point t)
(global-set-key (kbd "S-<insert>") (lambda ()
                                     (interactive)
                                     (mouse-yank-primary (point))))


;;; beginnings of el-get setup
(require 'init-el-get)

;;; org-mode
(require 'init-org)

;;; scheme stuff
(require 'init-scheme)

;;; systemd stuff
(require 'init-systemd)

;;; python stuff
(require 'init-python)

;; js
(require 'init-js)

;;; clojure
(require 'init-clojure)

;;; And znc
(require 'init-znc)

;;; NaRe

;; (el-get-bundle gist:4a65592d94885d217b34:narrow-reindent
;;   (require 'narrow-reindent)
;;   (add-hook 'prog-mode-hook #'narrow-reindent-mode))

;;; evil
(require 'init-evil)

;;; twittering-mode
;; (add-to-list 'modules:el-get-packages 'twittering-mode)
;; (eval-after-load "twittering-mode"
;;   (progn
;;     (add-hook 'twittering-mode-hook #'twittering-icon-mode)
;;     (setq twittering-use-master-password t)
;;     (setq twittering-oauth-invoke-browser t)
;;     (define-key twittering-mode-map (kbd "s") #'twittering-goto-previous-status)
;;     (define-key twittering-mode-map (kbd "t") #'twittering-goto-next-status)))

;;; eclim (java)

(el-get-bundle! popup
  (el-get-bundle! eclim
    (setenv "JAVA" "/usr/bin/java")
    (setenv "JAVA_HOME" nil)
    (require 'eclimd)
    (add-hook 'java-mode-hook #'eclim-mode)
    (require 'company-emacs-eclim)
    (company-emacs-eclim-setup)))

;;; install el-get packages
(finalize-el-get)

(setup-evil)

;; elpa/melpa/marmalade packages
(defvar package-refreshed nil
  "Used by `package-require' to determine whether to refresh package contents.")
(defadvice package-refresh-contents (after package-set-refreshed last activate)
  "Change `package-refreshed' to t after refreshing package contents."
  (setq package-refreshed t))
(package-initialize)

;;; my functions
(load "~/.emacs.d/functions.el")

(add-hook 'prog-mode-hook 'linum-mode)

(defadvice make-frame-command (after make-frame-change-background-color last activate)
  "Adjusts the background color for different frame types.
Graphical (X) frames should have the theme color, while terminal
frames should match the terminal color (which matches the theme
color...but terminal frames can't directly render this color)"
  (if (display-graphic-p)
      (set-background-color "#202020")
    (set-background-color "black")))

(setq-default fill-column 79)

(electric-indent-mode)

(global-set-key (kbd "M-W") 'yank-to-x-clipboard)
(global-set-key (kbd "C-c C-r") 'revert-all-buffers)
(global-set-key (kbd "M-Q") 'unfill-paragraph)

; tramp
(package-require 'tramp)

; disable vc on remote files
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

; wdired
(setq-default wdired-allow-to-change-permissions t)

; hideshow globally!
(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'jsx-mode-hook 'hs-minor-mode)
(eval-after-load "hideshow"
  '(progn
     (define-key hs-minor-mode-map (kbd "C-c s h") 'hs-hide-block)
     (define-key hs-minor-mode-map (kbd "C-c s s") 'hs-show-block)
     (define-key hs-minor-mode-map (kbd "C-c s a") 'hs-hide-all)
     (define-key hs-minor-mode-map (kbd "C-c s A") 'hs-show-all)
     (define-key hs-minor-mode-map (kbd "C-c h")   'hs-toggle-hiding)))
;; (add-hook 'js3-mode-hook #'hs-minor-mode)

; flyspell
(package-require 'flyspell)
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'jsx-mode-hook #'flyspell-prog-mode)

; auto-fill-mode
(add-hook 'text-mode-hook #'turn-on-auto-fill)

; latex mode
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "pdflatex " (buffer-file-name)))))

(package-require 'auctex)

;; flycheck
(package-require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

; projectile
(package-require 'projectile)
;; (projectile-global-mode -1)

(defun projectile-enable-unless-tramp ()
  "Enables `projectile-mode` unless in a TRAMP buffer."
  (unless (and (buffer-file-name)
               (file-remote-p (buffer-file-name)))
    (projectile-mode 1)))

(add-hook 'prog-mode-hook 'projectile-enable-unless-tramp)

(setq tags-revert-without-query t)
(defun projectile-custom-test-suffix (project-type)
  "Get custom test suffixes based on `PROJECT-TYPE'."
  (cond
   ((member project-type '(gulp grunt npm)) "_spec")
   (t (projectile-test-suffix project-type))))

;;; grep tweaks
(defvar greps '(grep lgrep grep-find rgrep zrgrep)
  "List of grep commands.")
;;; hide grep headers
(defun delete-grep-header ()
  "Hide the first 4 lines of the `grep-mode' buffer."
  (save-excursion
    (with-current-buffer grep-last-buffer
      (goto-line 5)
      (narrow-to-region (point) (point-max)))))

(defvar delete-grep-header-advice
  (ad-make-advice
   'delete-grep-header nil t
   '(advice lambda () (delete-grep-header))))

(defun add-delete-grep-header-advice (f)
  "Add the `delete-grep-header-advice' advice to `F'."
  (ad-add-advice f delete-grep-header-advice 'after 'first)
  (ad-activate f))

(mapc 'add-delete-grep-header-advice greps)

;;; focus grep buffer
(defun switch-to-grep ()
  "Switch to the `grep-mode' buffer."
  (switch-to-buffer-other-window grep-last-buffer))

(defvar switch-to-grep-advice
  (ad-make-advice
   'switch-to-grep nil t
   '(advice lambda () (switch-to-grep))))

(defun add-switch-to-grep-advice (f)
  "Add the `switch-to-grep-advice' advice to `F'."
  (ad-add-advice f switch-to-grep-advice 'after 'last)
  (ad-activate f))

(mapc 'add-switch-to-grep-advice greps)

; magit
(package-require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")

; multiple-cursors
(package-require 'multiple-cursors)
(global-set-key (kbd "C-c L") 'mc/edit-lines)
(global-set-key (kbd "C-c N") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c P") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c A") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c M-a") 'mc/mark-all-in-region)

;;; helm
(package-require 'helm)
(require 'helm-config)
(require 'helm-grep)
(package-require 'helm-projectile)
(defalias 'helm--make-source 'helm-make-source)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)

;; ace-jump-mode
(package-require 'ace-jump-mode)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; uniquify
(require 'uniquify)

;;; trying company-mode
(package-require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; paredit
(package-require 'paredit)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)

;; slime
(setq inferior-lisp-program "/usr/bin/sbcl")

(package-require 'slime)
(require 'slime-autoloads)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

;; lisp mode
(setq auto-mode-alist (append '(("/*.\.cl$" . lisp-mode)) auto-mode-alist))
(defadvice slime-edit-definition (before slime-edit-definition-push-mark)
  "Pushes the mark before jumping to the definition with `slime-edit-definition'."
  (push-mark))
(ad-activate 'slime-edit-definition)
(defun lisp-mode-keys ()
  "Defines key-bindings for `lisp-mode' (notably slime eval)."
  (local-set-key (kbd "C-c e") 'slime-eval-last-expression))
(add-hook 'lisp-mode-hook 'lisp-mode-keys)

;; yasnippet
(package-require 'yasnippet)
;;; (yas-global-mode 1)

;; ignoramus
(package-require 'ignoramus)
(ignoramus-setup)

;; web-mode
(package-require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
      '(("django" . "\\.html?\\'")))

;; indentation
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; disable startup screen and non-empty scratchpad
(setq-default inhibit-startup-screen t)
(setq initial-scratch-message "")

;; paren stuff
(show-paren-mode t)
(setq show-paren-delay 0)
;;; smartparens
(package-require 'smartparens)
(require 'smartparens-config)
(add-hook 'js2-mode-hook 'smartparens-strict-mode)
;;; TODO: smartparens hybrid keys for JS

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "M-`") 'lacarte-execute-menu-command)
(global-set-key (kbd "C-c q") 'auto-fill-mode)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c M-r") 'replace-regexp)

;; mode line stuff
(setq sml/theme 'respectful)
(package-require 'smart-mode-line)
(sml/setup)
(column-number-mode)

;;; ocaml stuff
(package-require 'tuareg)
(require 'merlin nil t)
(eval-after-load 'company
  '(add-to-list 'company-backends 'merlin-company-backend))
(package-require 'utop)
(eval-after-load 'tuareg
  '(progn
     (define-key tuareg-mode-map (kbd "RET") 'tuareg-newline-and-indent)
     (autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
     (add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
     (add-hook 'tuareg-mode-hook 'merlin-mode)
     (setq merlin-error-after-save t)))

;;; matlab-mode
(add-to-list 'load-path "~/.emacs.d/matlab/")
(autoload 'matlab-mode "matlab")
(add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))
(eval-after-load "matlab"
  '(progn (load-library "matlab-load")
          (matlab-cedet-setup)))

;;; desktop-save-mode
(setq desktop-dirname "~/")
(desktop-save-mode 0)

;;; mail!
(require 'mu4e nil t)
(if (fboundp 'mu4e)
    (require 'mu4e-config nil t))

;;; haskell
(package-require 'haskell-mode)
(add-hook 'haskell-mode-hook 'ghc-init)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(package-require 'company-ghc)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-ghc))

;;; semantic
(add-hook 'c-mode-hook 'semantic-mode)

;;; sql stuff
(add-hook 'sql-mode-hook 'sql-highlight-ansi-keywords)

;;; prolog
(defun prolog-inferior-next-solution ()
  (interactive)
  (comint-send-string nil ";")
  (comint-send-input))
(eval-after-load "prolog"
  '(define-key prolog-inferior-mode-map (kbd "C-n") #'prolog-inferior-next-solution))

;;; un-disabled fns
(put 'scroll-left 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;; pretty Control-L characters (overlay)
(defun overlay-control-l ()
  (font-lock-add-keywords
   nil
   `((,page-delimiter ;; variable with the regexp (usually "^\f" or "^^L")
      0
      (prog1 nil
        ;; hide ^L
        (compose-region (match-beginning 0) (match-end 0) "")
        ;; make an overlay (like in hl-line)
        (let ((pdl (make-overlay (line-beginning-position)
                                 (line-beginning-position 2))))
          ;; :background has to be different from the background color
          ;; gray1 here is just a little different from black
          (overlay-put pdl 'face '(:underline "#6F8F6F" :background "#303030"))
          (overlay-put pdl 'modification-hooks
                       ;; these arguments are received from modification-hooks
                       '((lambda (overlay after-p begin end &optional length)
                           (delete-overlay overlay))))
          (overlay-put pdl 'insert-in-front-hooks
                       '((lambda (overlay after-p begin end &optional length)
                           (delete-overlay overlay)))))) t))))
(add-hook 'after-change-major-mode-hook #'overlay-control-l)

;;; temp location for rainbow identifiers
(defun rainbow-identifiers-js2-filter (beg end)
  (and
   ;; (or (not (equal (buffer-substring-no-properties (- beg 1) beg) ".")))
   (js2-name-node-p (js2-node-at-point beg))))
;;; init.el ends here
