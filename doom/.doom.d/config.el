;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq! uniquify-buffer-name-style 'forward)
(setq doom-leader-key ",")
(setq doom-leader-alt-key "C-,")
(setq doom-localleader-key ", m")
(setq doom-localleader-alt-key "C-, m")

(map! :leader "b SPC" #'ivy-switch-buffer)
(map! :leader "p g" #'+ivy/project-search)
(map! :n "g b" #'better-jumper-jump-backward)

(after! evil-ex
  (evil-ex-define-cmd "kill" #'kill-this-buffer)
  (evil-ex-define-cmd "k" "kill"))

(after! evil-snipe
  (setq! evil-snipe-repeat-keys t)
  (setq! evil-snipe-override-evil-repeat-keys t))

(after! evil
  (evil-define-key '(normal motion) 'global
    "h" nil
    "j" nil
    "k" nil
    "l" nil
    (kbd "C-p") nil
    (kbd "M-a") 'evil-beginning-of-line
    (kbd "M-o") 'evil-end-of-line
    "k" 'evil-forward-word-end
    "n" 'evil-forward-char
    "e" 'evil-backward-char
    "s" 'evil-previous-line
    "t" 'evil-next-line
    "R" 'evil-ex-search-previous
    "r" 'evil-ex-search-next)

  (evil-define-key '(normal motion) evil-snipe-local-mode-map
    "s" nil
    "S" nil
    "j" 'evil-snipe-s
    "J" 'evil-snipe-S)

  (evil-define-key 'motion evil-snipe-override-local-mode-map
    "t" nil
    "T" nil
    "l" 'evil-snipe-t
    "L" 'evil-snipe-T)

  (evil-define-key nil evil-window-map
    "h" nil
    "j" nil
    "k" nil
    "l" nil
    "n" 'evil-window-right
    "e" 'evil-window-left
    "s" 'evil-window-up
    "t" 'evil-window-down
    "o" 'doom/window-maximize-buffer))

(setq projectile-project-search-path '("~/Code/" "~/Work/"))

(evil-define-key 'normal projectile-mode-map
  (kbd "C-p") '+ivy/projectile-find-file)

(after! rainbow-identifiers
  (setq! rainbow-identifiers-choose-face-function #'rainbow-identifiers-cie-l*a*b*-choose-face)
  (setq! rainbow-identifiers-faces-to-override '(font-lock-function-name-face font-lock-variable-name-face font-lock-type-face web-mode-variable-name-face web-mode-function-name-face web-mode-function-call-face))
  (setq! rainbow-identifiers-cie-l*a*b*-color-count (* 256 256 256)))

(add-hook 'prog-mode-hook #'rainbow-identifiers-mode)

;; js2 does some funky things with faces that makes every word (even in comments
;; and strings) show up in rainbow colors. turning rainbow-identifiers off for
;; js2
(after! js2-mode
  (add-hook! js2-mode :append (rainbow-identifiers-mode -1)))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "J David Smith"
      user-mail-address "emallson@emallson.net")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; (setq doom-font (font-spec :family "Source Code Pro")
;;       doom-unicode-font (font-spec :family "DejaVu Sans Mono"))
(setq doom-font (font-spec :family "Iosevka Extended"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'tao-yang)

(after! (tao-theme hl-line)
  (tao-with-color-variables
    tao-theme-yang-palette
    (custom-theme-set-faces! 'tao-yang
      `(hl-line :background ,color-5 :foreground unspecified)
      `(markdown-markup-face :foreground ,color-8))))

(after! company-box
  (custom-theme-set-faces! 'tao-yang
    '(company-tooltip :inherit unspecified)))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Comment settings
(map! :leader "c SPC" #'evilnc-comment-or-uncomment-lines)
;; technically this doesn't just add a new comment (which is what I want), but
(map! :leader "c n" #'comment-indent)

;; (after! ivy
;;   (defun ivy-ctrlp-escape ()
;;     (interactive)
;;     (unwind-protect
;;         (progn
;;           (setq minibuffer-message-timeout 0)
;;           (abort-recursive-edit))
;;       (run-at-time 0 nil (lambda () (setq minibuffer-message-timeout 2)))))

;;   (defvar ivy-ctrlp--recursed nil)

;;   (defun ivy-ctrlp-activate ()
;;     (interactive)
;;     (when (null ivy-ctrlp--recursed)
;;       (unwind-protect
;;           (progn
;;             (setq ivy-ctrlp--recursed t)
;;             (counsel-M-x))
;;         (setq ivy-ctrlp--recursed nil)))))

;; (map! :map ivy-minibuffer-map ">" #'ivy-ctrlp-activate
;;       :map ivy-minibuffer-map "M->" (lambda () (interactive) (insert-char ?>))
;;       :map ivy-minibuffer-map "<escape>" #'ivy-ctrlp-escape
;;       :map ivy-minibuffer-map "<C-return>" #'ivy-dispatching-done)

;; reconfiguring hydra-ivy --- nest vs hjkl + esc
(after! ivy-hydra
  (defhydra hydra-ivy (:hint nil
                       :color pink)
    "
^ ^ ^ ^ ^ ^ | ^Call^      ^ ^  | ^Cancel^ | ^Options^ | Action _w_/_k_/_a_: %-14s(ivy-action-name)
^-^-^-^-^-^-+-^-^---------^-^--+-^-^------+-^-^-------+-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^---------------------------
^ ^ _s_ ^ ^ | _f_ollow occ_U_r | _i_nsert | _c_: calling %-5s(if ivy-calling \"on\" \"off\") _C_ase-fold: %-10`ivy-case-fold-search
_e_ ^+^ _n_ | _d_one      ^ ^  | _o_ops   | _M_: matcher %-5s(ivy--matcher-desc)^^^^^^^^^^^^ _T_runcate: %-11`truncate-lines
^ ^ _t_ ^ ^ | _g_o        ^ ^  | ^ ^      | _<_/_>_: shrink/grow^^^^^^^^^^^^^^^^^^^^^^^^^^^^ _D_efinition of this menu
"
    ;; arrows
    ("e" ivy-beginning-of-buffer)
    ("t" ivy-next-line)
    ("s" ivy-previous-line)
    ("n" ivy-end-of-buffer)
    ;; mark
    ("m" ivy-mark)
    ("u" ivy-unmark)
    ("DEL" ivy-unmark-backward)
    ("l" ivy-toggle-marks)
    ;; actions
    ("o" keyboard-escape-quit :exit t)
    ("r" ivy-dispatching-done :exit t)
    ("C-g" keyboard-escape-quit :exit t)
    ("i" nil)
    ("C-o" nil)
    ("<escape>" nil)
    ("f" ivy-alt-done :exit nil)
    ("C-j" ivy-alt-done :exit nil)
    ("d" ivy-done :exit t)
    ("g" ivy-call)
    ("C-m" ivy-done :exit t)
    ("c" ivy-toggle-calling)
    ("M" ivy-rotate-preferred-builders)
    (">" ivy-minibuffer-grow)
    ("<" ivy-minibuffer-shrink)
    ("w" ivy-prev-action)
    ("k" ivy-next-action)
    ("a" (let ((ivy-read-action-function #'ivy-read-action-by-key))
           (ivy-read-action)))
    ("T" (setq truncate-lines (not truncate-lines)))
    ("C" ivy-toggle-case-fold)
    ("U" ivy-occur :exit t)
    ("D" (ivy-exit-with-action
          (lambda (_) (find-function 'hydra-ivy/body)))
     :exit t)))

(after! lispy
  (lispy-set-key-theme '(paredit c-digits))
  (setq! lispyville-key-theme '(operators c-w slurp/barf-lispy additional))
  (add-hook! (list clojurescript-mode clojure-mode clojurec-mode cider-repl-mode) :append (setq! completion-at-point-functions (remove #'lispy-clojure-complete-at-point completion-at-point-functions)))
  (defun lispy--clojure-middleware-load () nil))

(map! :leader "P s" #'profiler-start)
(after! profiler
  (map! :leader "P t" #'profiler-stop
        :leader "P r" #'profiler-report))

(after! clojure
  (modify-syntax-entry ?- "w" clojure-mode-syntax-table))

(setq tab-width 2)

(after! web-mode
  (setq! web-mode-code-indent-offset 2)
  (setq! web-mode-markup-indent-offset 2)
  (setq! web-mode-css-indent-offset 2))

;; (add-hook 'after-change-major-mode-hook (defun disable-prettify-symbols-mode ()
;;                                           (prettify-symbols-mode -1)))

;; (setq +ligatures-extras-in-modes nil)
;; (global-prettify-symbols-mode -1)

(setq! csv-separators (list "|" "," "	"))

(after! js
  (setq! js-indent-level 2))
