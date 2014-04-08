;;; init.el --- Configuration for emacs
;;; Commentary:
;;; Writing this to shut up Checkdoc
;;; I'll be really pissed if I ever lose this
;;; I should back it up, really.
;;; Code:
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(load-theme 'zenburn t)

(setq-default fill-column 80)

; my functions
(load "~/.emacs.d/functions.el")

(global-set-key (kbd "M-W") 'yank-to-x-clipboard)

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
(global-set-key (kbd "C-x g") 'google-this-mode-submap)

;; matlab - commented out cuz I'm using octave atm
;; (add-to-list 'load-path "~/.emacs.d/matlab")
;; (require 'matlab-load)

;; php
(autoload 'php-mode "php-mode.el" "Php mode." t)
;(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))

;; ESS
(add-to-list 'load-path "~/.emacs.d/ess")
(require 'ess-site)

;; elpa/melpa packages
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

;; slime
(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime)
(slime-setup '(slime-repl))

;; lisp mode
(setq auto-mode-alist (append '(("/*.\.cl$" . lisp-mode)) auto-mode-alist))
(defun lisp-mode-keys ()
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
(subword-mode 1)

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
(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
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
(require 'org)
(org-defkey org-mode-map (kbd "C-c s d") 'org-demote-subtree)
(org-defkey org-mode-map (kbd "C-c s p") 'org-promote-subtree)
(org-defkey org-mode-map (kbd "C-c d") 'org-do-demote)

;; smalltalk
(require 'smalltalk-mode)
(require 'gst-mode)
(add-to-list 'auto-mode-alist '("\\.st$" . smalltalk-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "xdg-open") (output-html "xdg-open"))))
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups/"))))
 '(browse-url-browser-function (quote browse-url-chromium))
 '(comment-auto-fill-only-comments t)
 '(custom-safe-themes (quote ("e88e253e38a442679ebd43cbd75d56f0659f568881cb6977527f0b0bd7e03080" "b621af558778c09cd767d8bc3923552b1066cad5f398fb3ed6abf029dde69ffa" "3090af8bd70378df5c78fdcbdf20539eaccac7d0f3d948bd0f0a3245e59b82bc" "e5e0e4e20697cd7c2a8ab900246db214241a826d5348e0cd943b0aadc57d6170" "26cec1daa06ecf8191983cfbe8a4b33115529111093c7d4b3b19b37e2c54c625" "729372c7d16866ab00ae494ebcd9f5c9f91477e0adffec585e170bdab107361c" "5d65ef430d457bcf697f2dc2c3de3f270a7b6709f48cc96184dc286b84805240" "a14fa334282295971b68538b2d64593472a5dd09534dd48f3db748e534d10377" "9fc8b10d1bb9ff26507114013a9283c49ac1e09a5b67a12755ec67bedb18fc98" "6bbe1f9067adbc38752fc2b1e9ead7b660b0fc92034a52cb09843413ecd311ed" "1c2253db4f3c34e54cad751372ba54c0eb114fb7f6a4a4fb9c44d1f250bf5416" "22b0cb305c407fe7220501c46e0bc36c34dc10138f8c61dee72079340cd838f5" "3c7d756bfd56e4fe67baecbe1e972fea7c5374b7457839d179e73823d6d9f2ac" default)))
 '(fci-rule-color "#383838")
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(fortran-minimum-statement-indent-fixed 8)
 '(ignoramus-file-basename-endings (quote (".386" ".a" ".acn" ".acr" ".alg" ".ap_" ".apk" "_archive" ".asv" "-autoloads.el" ".aux" ".bak" ".bbl" ".beam" ".bin" ".blg" ".cgo1.go" ".cgo2.c" ".chi" ".chi.h" ".class" ".com" ".cp" ".cps" ".d64fsl" ".dcu" ".dep" ".dex" ".dfsl" ".dll" ".drc" ".drv" ".dvi" ".dx32fsl" ".dx64fsl" ".dxl" ".dylib" ".ear" ".elc" ".esproj" "-Ex.R" ".exe" ".fas" ".fasl" ".fdb_latexmk" ".fmx" ".fn" ".fns" ".fsl" ".fx32fsl" ".fx64fsl" ".gcda" ".gcno" ".gcov" ".glg" ".glo" ".gls" ".gmo" ".hi" ".identcache" ".ilg" ".ilk" ".iml" ".ind" ".ipr" ".ist" ".iws" ".jar" ".ky" ".kys" ".la" ".lai" ".launch" ".lbin" ".lib" ".lnk" ".lo" ".lock" ".lof" ".lot" ".lx32fsl" ".lx64fsl" ".maf" ".mem" ".min.js" "-min.js" ".min.css" "-min.css" ".mmx" ".mo" ".moved-aside" ".mtc" ".mtc0" ".nav" ".nlo" ".o" ".obj" ".opensdf" ".orig" ".p64fsl" ".pdfsync" ".pfsl" ".pg" ".pgs" ".pid" ".pidb" ".plt" ".plx" ".pot" ".psess" ".Publish.xml" ".pyc" ".pyd" ".pydevproject" ".pyo" ".rbc" ".rej" ".sassc" ".scc" ".sdf" ".seed" ".sln.docstates" ".slo" ".snm" ".so" ".sparcf" ".sublime-project" ".sublime-workspace" ".suo" ".swo" ".swp" ".sx32fsl" ".sx64fsl" ".synctex.gz" ".ttc" ".tfm" ".tmproj" ".tmproject" ".toc" ".tp" ".tps" ".ufsl" ".un~" ".vr" ".vrb" ".vrs" ".vsp" ".vspscc" ".vssscc" ".vxd" ".war" ".wx32fsl" ".wx64fsl" ".x86f" ".xdy" ".zwc" "~")))
 '(js3-auto-indent-p nil)
 '(js3-dont-rebind-backtick t)
 '(js3-electric-keys (quote nil))
 '(js3-highlight-level 3)
 '(js3-indent-dots t)
 '(js3-indent-level 4)
 '(js3-indent-on-enter-key nil)
 '(js3-reparse-on-indent nil)
 '(js3-strict-missing-semi-warning t)
 '(org-drawers (quote ("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "CONTEXT" "HIDDEN")))
 '(org-export-date-timestamp-format "%d %B %Y")
 '(org-export-html-protect-char-alist (quote (("<" . "&lt;") (">" . "&gt;"))))
 '(org-export-latex-minted-langs (quote ((emacs-lisp "common-lisp") (cc "c++") (cperl "perl") (shell-script "bash") (caml "ocaml") (clojure "clojure"))))
 '(org-latex-default-packages-alist (quote (("AUTO" "inputenc" t) ("T1" "fontenc" t) ("" "fixltx2e" nil) ("" "graphicx" t) ("" "longtable" nil) ("" "float" nil) ("" "wrapfig" nil) ("" "rotating" nil) ("normalem" "ulem" t) ("" "amsmath" t) ("" "textcomp" t) ("" "marvosym" t) ("" "wasysym" t) ("" "amssymb" t) ("" "hyperref" nil) "\\tolerance=1000" ("" "minted" t) ("" "microtype" nil))))
 '(org-latex-listings (quote minted))
 '(org-latex-pdf-process (quote ("pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f")))
 '(org-latex-to-pdf-process (quote ("pdflatex -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f")))
 '(org2blog/wp-blog-alist (quote (("Record of Motion" :username "emallson" :url "http://emallson.wordpress.com/xmlrpc.php"))))
 '(org2blog/wp-show-post-in-browser (quote show))
 '(org2blog/wp-use-wp-latex t)
 '(package-archives (quote (("melpa" . "http://melpa.milkbox.net/packages/") ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(projectile-enable-idle-timer t)
 '(projectile-globally-ignored-directories (quote (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" "build" "venv" "virtualenv")))
 '(projectile-globally-ignored-files (quote ("TAGS" "*.min.css")))
 '(projectile-tags-command "ctags -e -R --exclude=target --exclude=.repl --exclude=.git --exclude=resources --exclude=doc --exclude=LICENSE --exclude=.gitignore --exclude=venv --exclude=virtualenv --exclude=\"*min.js\" --exclude=\"*#*\" %s")
 '(reb-re-syntax (quote string))
 '(tab-stop-list (loop with i = 0 do (setf i (+ i 4)) until (= i 120) collect i))
 '(tab-width 4)
 '(tags-add-tables nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(web-mode-code-indent-offset 4)
 '(web-mode-enable-auto-pairing t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js3-external-variable-face ((t (:foreground "color-105")))))
(put 'upcase-region 'disabled nil)
