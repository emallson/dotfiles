;;; init.el --- Configuration for emacs
;;; Commentary:
;;; Writing this to shut up Checkdoc
;;; I'll be really pissed if I ever lose this
;;; I should back it up, really.
;;; Code:
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(load-theme 'zenburn t)
(set-frame-font "Source Code Pro Light:size=17:antialias=true")
(defadvice make-frame-command (after make-frame-change-background-color last)
  "Adjusts the background color for different frame types.
Graphical (X) frames should have the theme color, while terminal
frames should match the terminal color (which matches the theme
color...but terminal frames can't directly render this color)"
  (if (display-graphic-p)
      (set-background-color "#202020")
    (set-background-color "black")))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq-default fill-column 79)

; my functions
(load "~/.emacs.d/functions.el")

(global-set-key (kbd "M-W") 'yank-to-x-clipboard)
(global-set-key (kbd "C-c C-r") 'revert-all-buffers)

; tramp
(require 'tramp)
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))

; wdired
(setq-default wdired-allow-to-change-permissions t)

; hideshow globally!
(add-hook 'prog-mode-hook #'hs-minor-mode)
(add-hook 'jsx-mode-hook #'hs-minor-mode)
(add-hook 'js3-mode-hook #'hs-minor-mode)

; flyspell
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'jsx-mode-hook #'flyspell-prog-mode)
(add-hook 'js3-mode-hook #'flyspell-prog-mode)

; auto-fill-mode
(add-hook 'text-mode-hook #'turn-on-auto-fill)

; latex mode
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "pdflatex " (buffer-file-name)))))

(require 'column-marker)
(add-hook 'js3-mode-hook (lambda () (interactive) (column-marker-1 81)))
(add-hook 'fortran-mode-hook (lambda () (interactive) (column-marker-1 81)))

(require 'lacarte)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; google-this
(require 'google-this)
(google-this-mode 1)
(global-set-key (kbd "C-c f") 'google-search)
(global-set-key (kbd "C-x C-g") 'google-this-mode-submap)

;; matlab - commented out cuz I'm using octave atm
;; (add-to-list 'load-path "~/.emacs.d/matlab")
;; (require 'matlab-load)

;; php
(autoload 'php-mode "php-mode.el" "Php mode." t)
;(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))

;; elpa/melpa/marmalade packages
;;
;; I am fully aware that the packages installed through package.el do not need
;; to be (require)'d, but for uniformity with other packages (eg ido, uniquify)
;; and for future-proofing I am using them
(package-initialize)

; projectile
(require 'projectile)
(projectile-global-mode)
(setq tags-revert-without-query t)

; magit
(require 'magit)

; evil-numbers
(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c L") 'mc/edit-lines)
(global-set-key (kbd "C-c N") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c P") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c A") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c M-a") 'mc/mark-all-in-region)

;; ido
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
;; ido-better-flex
(require 'ido-better-flex)
(ido-better-flex/enable)
;; ido-vertical-mode
(require 'ido-vertical-mode)
(ido-vertical-mode)
;; kill-ring-ido
(require 'kill-ring-ido)
(global-set-key (kbd "C-M-y") 'kill-ring-ido)

;; smex -- only using it for major modes because it is very slow over all
;; functions
(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; ace-jump-mode
(require 'ace-jump-mode)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; uniquify
(require 'uniquify)

;; slime
(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime)
(slime-setup '(slime-repl))
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(require 'ac-slime)
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

;; paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(ac-flyspell-workaround)

;; clojure stuff
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(require 'ac-cider-compliment)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-compliment-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-compliment-repl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes cider-mode))

;; no-easy-keys
;; time to stop using them thar arrows
(require 'no-easy-keys)
(no-easy-keys 1)

;; ignoramus
(require 'ignoramus)
(ignoramus-setup)

;; js
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
;; jsx
;; (add-to-list 'auto-mode-alist '("\\.jsx$\\'" . jsx-mode))
;; (add-to-list 'magic-mode-alist '("^/\\*\\* +@jsx.+ \\*/$" . jsx-mode))
;; (autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;; web-mode
(require 'web-mode)
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
;; (add-to-list 'load-path "~/org-mode/lisp/") ;; was used to export while the URL bug was still in place
(require 'org)
(org-defkey org-mode-map (kbd "C-c s d") 'org-demote-subtree)
(org-defkey org-mode-map (kbd "C-c s p") 'org-promote-subtree)
(org-defkey org-mode-map (kbd "C-c d") 'org-do-demote)
(org-defkey org-mode-map (kbd "C-c SPC") nil)
(org-defkey org-mode-map (kbd "C-c a l") 'org-timeline)
(global-set-key (kbd "C-c a a") 'org-agenda-list)
(global-set-key (kbd "C-c a t") 'org-todo-list)

;; chrome integration
(require 'edit-server)
(edit-server-start)

;; sublimity -- only start this when running under X
(require 'sublimity)
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
(require 'smart-mode-line)
(sml/setup)
(column-number-mode)


;; paradox
(require 'paradox)
(setq paradox-github-token "6b29de76c9e601977d611044edd285d6cc67d48a")

;; god-mode
(require 'god-mode)
(global-set-key (kbd "C-x g") 'god-mode)

;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;; init.el ends here
(put 'scroll-left 'disabled nil)
