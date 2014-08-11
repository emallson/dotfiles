;;; init.el --- Configuration for emacs
;;; Commentary:
;;; Writing this to shut up Checkdoc
;;; I'll be really pissed if I ever lose this
;;; I should back it up, really.
;;; Code:
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(require 'cl)
(load-theme 'zenburn t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; elpa/melpa/marmalade packages
(defvar package-refreshed nil
  "Used by `package-require' to determine whether to refresh package contents.")
(defadvice package-refresh-contents (after package-set-refreshed last activate)
  "Change `package-refreshed' to t after refreshing package contents."
  (setq package-refreshed t))
(package-initialize)

;;; my functions
(load "~/.emacs.d/functions.el")

(set-default-font "Source Code Pro Light:size=15:antialias=true")
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
;; (add-to-list 'tramp-default-proxies-alist
;;              '(nil "\\`root\\'" "/ssh:%h:"))
;; (add-to-list 'tramp-default-proxies-alist
;;              '((regexp-quote (system-name)) nil nil))

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
     (define-key hs-minor-mode-map (kbd "C-c s A") 'hs-show-all)))
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

(require 'lacarte)

;; flycheck
(package-require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

; projectile
(package-require 'projectile)
(projectile-global-mode)
(setq tags-revert-without-query t)
(defun projectile-custom-test-suffix (project-type)
  "Get custom test suffixes based on `PROJECT-TYPE'."
  (cond
   ((member project-type '(grunt npm)) "_spec")
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

; evil-numbers
(package-require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

; multiple-cursors
(package-require 'multiple-cursors)
(global-set-key (kbd "C-c L") 'mc/edit-lines)
(global-set-key (kbd "C-c N") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c P") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c A") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c M-a") 'mc/mark-all-in-region)

;; ;; ido
;; (package-require 'ido)
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)
;; (setq ido-use-filename-at-point 'guess)
;; (setq ido-default-buffer-method 'selected-window)
;; ;; ido-better-flex
;; (package-require 'ido-better-flex)
;; (ido-better-flex/enable)
;; ;; ido-vertical-mode
;; (package-require 'ido-vertical-mode)
;; (ido-vertical-mode)
;; ;; kill-ring-ido
;; (require 'kill-ring-ido)
;; (global-set-key (kbd "C-M-y") 'kill-ring-ido)

;; ;; smex -- only using it for major modes because it is very slow over all
;; ;; functions
;; (package-require 'smex)
;; (smex-initialize)

;;; helm
(package-require 'helm)
(require 'helm-config)
(require 'helm-grep)
(package-require 'helm-projectile)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)

;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; ace-jump-mode
(package-require 'ace-jump-mode)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; uniquify
(require 'uniquify)

;; auto-complete
;; (package-require 'auto-complete)
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (ac-flyspell-workaround)

;;; trying company-mode
(package-require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; clojure stuff
(package-require 'clojure-mode)
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.cljs?.hl\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))
;;; indentation for compojure
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
  (page 'defun))

(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map (kbd "RET") 'paredit-newline))

(package-require 'cider)
(require 'cider-mode)
(unless (boundp 'cider-mode-hook)
  (message "Oops! cider-mode-hook is unbound!")
  (defvar cider-mode-hook nil
    "Hook that is run when `cider-mode' is activated."))
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(eval-after-load 'cider
  '(define-key cider-repl-mode-map (kbd "RET") 'cider-repl-return))
(setq nrepl-hide-special-buffers t)

(package-require 'company-cider)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-cider))

(package-require 'ac-cider-compliment)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-compliment-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-compliment-repl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes cider-mode))

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
(slime-setup '(slime-repl))
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

(package-require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))
(add-hook 'c-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-c-headers)
            (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))

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
(yas-global-mode 1)

;; no-easy-keys
;; time to stop using them thar arrows
(require 'no-easy-keys)
(no-easy-keys 1)

;; ignoramus
(package-require 'ignoramus)
(ignoramus-setup)

;; js
(package-require 'js2-mode)
(package-require 'nodejs-repl)
(require 'nodejs-repl-eval)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(define-key js2-mode-map (kbd "C-c M-j") 'nodejs-repl)
(define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-eval-dwim)
(define-key js2-mode-map (kbd "C-x M-e") 'nodejs-repl-eval-function)
(define-key js2-mode-map (kbd "C-x C-M-e") 'nodejs-repl-eval-buffer)
(define-key js2-mode-map (kbd "M-RET") 'js2-line-break)
(define-key js2-mode-map (kbd "RET") 'js2-line-break)
(add-hook 'js2-mode-hook 'subword-mode)

;;; tern
;; (add-to-list 'load-path "~/.emacs.d/tern/emacs/")
;; (autoload 'tern-mode "tern.el" nil t)
(package-require 'tern)
(package-require 'tern-auto-complete)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

;; jsx
;; (add-to-list 'auto-mode-alist '("\\.jsx$\\'" . jsx-mode))
;; (add-to-list 'magic-mode-alist '("^/\\*\\* +@jsx.+ \\*/$" . jsx-mode))
;; (autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;; web-mode
(package-require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
      '(("django" . "\\.html?\\'")))

;; subword-mode
;; makes cursor movement stop in camelCase variables
;; (subword-mode 1) ; need to add as hook for certain modes ... or all modes?

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
(define-key smartparens-strict-mode-map (kbd "C-<right>") 'sp-slurp-hybrid-sexp)
(define-key smartparens-strict-mode-map (kbd "M-r") 'sp-raise-sexp)


;; shows the matching paren in the minibuffer when it is off-screen
(defadvice show-paren-function (after show-matching-paren-offscreen activate)
  "Show matching paren with context in the minibuffer if it is off-screen.
Has no effect if the character before point is not of
the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
         (matching-text (and cb
                             (char-equal (char-syntax cb) ?\) )
                             (blink-matching-open))))
    (when matching-text (message matching-text))))

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "M-`") 'lacarte-execute-menu-command)
(global-set-key (kbd "C-c q") 'auto-fill-mode)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c M-r") 'replace-regexp)


;; org mode
(package-require 'org)
(eval-after-load "org"
  '(progn
     (org-defkey org-mode-map (kbd "C-c s d") 'org-demote-subtree)
     (org-defkey org-mode-map (kbd "C-c s p") 'org-promote-subtree)
     (org-defkey org-mode-map (kbd "C-c d") 'org-do-demote)
     (org-defkey org-mode-map (kbd "C-c SPC") nil)
     (org-defkey org-mode-map (kbd "C-c a l") 'org-timeline)
     (org-defkey org-mode-map (kbd "C-c C-x t") 'org-set-tags)
     (org-defkey org-mode-map (kbd "C-x C-e") 'org-emphasize)
     (global-set-key (kbd "C-c a a") 'org-agenda-list)
     (global-set-key (kbd "C-c a t") 'org-todo-list)
     (global-set-key (kbd "C-c a m") 'org-tags-view)))

(add-hook 'org-mode-hook (lambda () (electric-indent-mode 0)))

(package-require 'htmlize)

;; chrome integration
(package-require 'edit-server)
(edit-server-start)

;; sublimity -- only start this when running under X
(package-require 'sublimity)
(require 'sublimity-scroll)
;; (require 'sublimity-map)
(defadvice switch-to-buffer (after switch-to-buffer-toggle-sublimity last)
  "Enable `sublimity-mode' only in graphical (X) windows.

Scrolling works okay-ish in the terminal, but map doesn't work at all."
  (if (display-graphic-p)
      (sublimity-mode)
    (sublimity-mode -1)))
(ad-activate 'switch-to-buffer)

(put 'upcase-region 'disabled nil)

;; mode line stuff
(setq sml/theme 'respectful)
(package-require 'smart-mode-line)
(sml/setup)
(column-number-mode)

;; paradox
(package-require 'paradox)
(setq paradox-github-token "6b29de76c9e601977d611044edd285d6cc67d48a")

;; god-mode
(package-require 'god-mode)
(global-set-key (kbd "C-x g") 'god-mode)

;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;; ocaml stuff
(package-require 'tuareg)
(require 'merlin)
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



;;; desktop-save-mode
(setq desktop-dirname "~/")
(desktop-save-mode 0)

;;; un-disabled fns
(put 'scroll-left 'disabled nil)

;;; init.el ends here
