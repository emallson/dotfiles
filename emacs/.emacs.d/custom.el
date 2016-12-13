(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "xdg-open")
     (output-html "xdg-open"))))
 '(ac-quick-help-delay 1.0)
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups/"))))
 '(before-save-hook (quote (delete-trailing-whitespace)))
 '(browse-url-browser-function (quote browse-url-chromium))
 '(c-basic-offset 2)
 '(c-default-style
   (quote
    ((java-mode . "java")
     (awk-mode . "awk")
     (other . "linux"))))
 '(cider-boot-command "/home/emallson/.local/bin/boot")
 '(cider-boot-parameters "cider repl -s wait")
 '(cider-default-repl-command "boot")
 '(comment-auto-fill-only-comments t)
 '(company-backends
   (quote
    (company-ghc merlin-company-backend company-tern company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf
                 (company-dabbrev-code company-gtags company-keywords)
                 company-oddmuse company-files company-dabbrev)))
 '(compilation-read-command nil)
 '(create-lockfiles nil)
 '(custom-safe-themes
   (quote
    ("40bc0ac47a9bd5b8db7304f8ef628d71e2798135935eb450483db0dbbfff8b11" "603a9c7f3ca3253cb68584cb26c408afcf4e674d7db86badcfe649dd3c538656" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "3a9ff11d1337a00ca267f1d94dd4a8cdcee083014a9ef13d6c25bb11a9eac199" "e88e253e38a442679ebd43cbd75d56f0659f568881cb6977527f0b0bd7e03080" "b621af558778c09cd767d8bc3923552b1066cad5f398fb3ed6abf029dde69ffa" "3090af8bd70378df5c78fdcbdf20539eaccac7d0f3d948bd0f0a3245e59b82bc" "e5e0e4e20697cd7c2a8ab900246db214241a826d5348e0cd943b0aadc57d6170" "26cec1daa06ecf8191983cfbe8a4b33115529111093c7d4b3b19b37e2c54c625" "729372c7d16866ab00ae494ebcd9f5c9f91477e0adffec585e170bdab107361c" "5d65ef430d457bcf697f2dc2c3de3f270a7b6709f48cc96184dc286b84805240" "a14fa334282295971b68538b2d64593472a5dd09534dd48f3db748e534d10377" "9fc8b10d1bb9ff26507114013a9283c49ac1e09a5b67a12755ec67bedb18fc98" "6bbe1f9067adbc38752fc2b1e9ead7b660b0fc92034a52cb09843413ecd311ed" "1c2253db4f3c34e54cad751372ba54c0eb114fb7f6a4a4fb9c44d1f250bf5416" "22b0cb305c407fe7220501c46e0bc36c34dc10138f8c61dee72079340cd838f5" "3c7d756bfd56e4fe67baecbe1e972fea7c5374b7457839d179e73823d6d9f2ac" default)))
 '(desktop-path (quote ("~/.emacs.d/desktop/" "~/.emacs.d/" "~")))
 '(dirtrack-list (quote ("\\[\\(.*\\)\\]" 1)))
 '(display-battery-mode t)
 '(doc-view-scale-internally nil)
 '(eclim-eclipse-dirs
   (quote
    ("~/software/eclipse" "/Applications/eclipse" "/usr/lib/eclipse" "/usr/local/lib/eclipse" "/usr/share/eclipse")))
 '(eclim-executable "~/software/eclipse/eclim")
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(edit-server-new-frame nil)
 '(el-get-notify-type (quote message))
 '(elpy-interactive-python-command "ipython")
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults)))
 '(elpy-rpc-backend "jedi")
 '(elpy-rpc-python-command "python3")
 '(emms-mode-line-format "")
 '(emms-mode-line-mode-line-function nil)
 '(emms-player-mpd-music-directory "~/Music")
 '(emms-playlist-default-major-mode (quote emms-mark-mode))
 '(emms-source-file-default-directory "~/Music/")
 '(erc-accidental-paste-threshold-seconds 0.25)
 '(erc-auto-set-away nil)
 '(erc-autojoin-channels-alist
   (quote
    (("freenode" "#emacs" "#evil-mode" "#hoplon" "#haskell" "#xmonad" "#clojure"))))
 '(erc-autojoin-mode nil)
 '(erc-autojoin-timing (quote ident))
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services stamp track)))
 '(erc-nick "Atlanis")
 '(erc-prompt-for-nickserv-password nil)
 '(erc-prompt-for-password nil)
 '(erc-track-faces-priority-list
   (quote
    (erc-error-face erc-current-nick-face erc-keyword-face erc-pal-face erc-dangerous-host-face erc-prompt-face)))
 '(erc-track-priority-faces-only (quote all))
 '(evil-cross-lines t)
 '(explicit-shell-file-name "/usr/bin/zsh")
 '(fci-rule-color "#383838")
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(flycheck-clang-language-standard "c++11")
 '(flycheck-gcc-language-standard "c++11")
 '(flycheck-global-modes (quote (not haskell-mode)))
 '(flycheck-perl-include-path (quote ("/home/emallson/perl5/lib/perl5/")))
 '(font-lock-global-modes (quote (not speedbar-mode erc-mode)))
 '(fortran-minimum-statement-indent-fixed 8)
 '(fringe-mode 0 nil (fringe))
 '(geiser-active-implementations (quote (guile racket chez)))
 '(geiser-default-implementation (quote racket))
 '(geiser-racket-extra-keywords
   (quote
    ("provide" "require" "unless" "when" "with-handlers" "define:" "lambda:" "let:" "option")))
 '(global-writeroom-mode t nil (writeroom-mode))
 '(gnus-init-file "~/.emacs.d/gnus.el")
 '(grep-find-ignored-directories
   (quote
    ("$RECYCLE.BIN" ".AppleDouble" ".DS_Store" ".DocumentRevisions-V100" ".LSOverride" ".Rhistory" ".Spotlight-V100" ".TemporaryItems" ".Trashes" ".actionScriptProperties" ".apt_generated" ".bdfcache.el" ".build" ".buildpath" ".builds" ".bzr" ".cdv" ".classpath" ".com.apple.timemachine.donotpresent" ".com.apple.timemachine.supported" ".coverage" ".cproject" ".directory" ".dropbox" ".dropbox.cache" ".emacs-places" ".emacs.desktop" ".emacs.desktop.lock" ".eunit" ".externalToolBuilders" ".flexProperties" ".fseventsd" ".git" ".hg" ".idea" ".idlwave" ".ido.last" ".kkcrc" ".last_cover_stats" ".lein-deps-sum" ".loadpath" ".netrwhist" ".notes" ".org-id-locations" ".pc" ".project" ".projectile" ".prove" ".puppet-bak" ".quickurls" ".recentf" ".redcar" ".rspec" ".sass-cache" ".scala_dependencies" ".shadow_todo" ".shadows" ".strokes" ".svn" ".timelog" ".todo-do" ".todo-done" ".todo-top" ".tox" ".type-break" ".vip" ".viper" ".wmncach.el" ".yardoc" "_MTN" "__history" "_bdfcache.el" "_build" "_cgo_defun.c" "_cgo_gotypes.go" "_darcs" "_obj" "_sgbak" "_site" "_test" "_testmain.go" "_yardoc" "aclocal.m4" "auto-save-list" "autom4te.cache" "bin-debug" "bin-release" "blib" "build" "Build" "Build.bat" "COMMIT_EDITMSG" "cmake_install.cmake" "CMakeCache.txt" "CMakeFiles" "cover_db" "cscope.csd" "cscope.files" "cscope.inc" "cscope.lst" "cscope.out" "cscope.out.po" "cscope.tmplist" "CVS" "Debug" "debug" "depcomp" "DerivedData" "Desktop.ini" "ehthumbs.db" "GHI_ISSUE" "git-rebase-todo" "gwt-unitCache" "gwt_bree" "install-sh" "install_manifest.txt" "InstalledFiles" "Makefile.in" "Makefile.old" "MCVS" "META.yml" "MERGE_MSG" "minimal-session-saver-data.el" "MYMETA.yml" "nbbuild" "nbdist" "nosetests.xml" "nytprof" "nytprof.out" "perltidy.ERR" "pm_to_blib" "Profile" "profile" "RCS" "Release" "release" "SCCS" "Session.vim" "slprj" "SQUASH_MSG" "TAGS" "TAG_EDITMSG" "tags" "TestResult" "testresult" "Thumbs.db" "tmtags" "xcuserdata" "xhtml-loader.rnc" "{arch}" "~.dep" "~.dot" "~.nib" "~.plst" "test.out" "test_out" "test.output" "test_output" "doc" "coverage")))
 '(haskell-process-type (quote stack-ghci))
 '(helm-buffers-fuzzy-matching t)
 '(helm-ff-auto-update-initial-value t)
 '(helm-ff-skip-boring-files t)
 '(helm-quick-update t)
 '(ignoramus-file-basename-endings
   (quote
    (".386" ".a" ".acn" ".acr" ".alg" ".ap_" ".apk" "_archive" ".asv" "-autoloads.el" ".aux" ".bak" ".bbl" ".beam" ".bin" ".blg" ".cgo1.go" ".cgo2.c" ".chi" ".chi.h" ".class" ".com" ".cp" ".cps" ".d64fsl" ".dcu" ".dep" ".dex" ".dfsl" ".dll" ".drc" ".drv" ".dvi" ".dx32fsl" ".dx64fsl" ".dxl" ".dylib" ".ear" ".elc" ".esproj" "-Ex.R" ".exe" ".fas" ".fasl" ".fdb_latexmk" ".fmx" ".fn" ".fns" ".fsl" ".fx32fsl" ".fx64fsl" ".gcda" ".gcno" ".gcov" ".glg" ".glo" ".gls" ".gmo" ".hi" ".identcache" ".ilg" ".ilk" ".iml" ".ind" ".ipr" ".ist" ".iws" ".jar" ".ky" ".kys" ".la" ".lai" ".launch" ".lbin" ".lib" ".lnk" ".lo" ".lock" ".lof" ".lot" ".lx32fsl" ".lx64fsl" ".maf" ".mem" ".min.js" "-min.js" ".min.css" "-min.css" ".mmx" ".mo" ".moved-aside" ".mtc" ".mtc0" ".nav" ".nlo" ".o" ".obj" ".opensdf" ".orig" ".p64fsl" ".pdfsync" ".pfsl" ".pg" ".pgs" ".pid" ".pidb" ".plt" ".plx" ".pot" ".psess" ".Publish.xml" ".pyc" ".pyd" ".pydevproject" ".pyo" ".rbc" ".rej" ".sassc" ".scc" ".sdf" ".seed" ".sln.docstates" ".slo" ".snm" ".so" ".sparcf" ".sublime-project" ".sublime-workspace" ".suo" ".swo" ".swp" ".sx32fsl" ".sx64fsl" ".synctex.gz" ".ttc" ".tfm" ".tmproj" ".tmproject" ".toc" ".tp" ".tps" ".ufsl" ".un~" ".vr" ".vrb" ".vrs" ".vsp" ".vspscc" ".vssscc" ".vxd" ".war" ".wx32fsl" ".wx64fsl" ".x86f" ".xdy" ".zwc" "~" "venv")))
 '(ignoramus-file-basename-exact-names
   (quote
    ("$RECYCLE.BIN" ".AppleDouble" ".DS_Store" ".DocumentRevisions-V100" ".LSOverride" ".Rhistory" ".Spotlight-V100" ".TemporaryItems" ".Trashes" ".actionScriptProperties" ".apt_generated" ".bdfcache.el" ".build" ".buildpath" ".builds" ".bzr" ".cdv" ".classpath" ".com.apple.timemachine.donotpresent" ".com.apple.timemachine.supported" ".coverage" ".cproject" ".directory" ".dropbox" ".dropbox.cache" ".emacs-places" ".emacs.desktop" ".emacs.desktop.lock" ".eunit" ".externalToolBuilders" ".flexProperties" ".fseventsd" ".git" ".hg" ".idea" ".idlwave" ".ido.last" ".kkcrc" ".last_cover_stats" ".lein-deps-sum" ".loadpath" ".netrwhist" ".notes" ".org-id-locations" ".pc" ".project" ".projectile" ".prove" ".puppet-bak" ".quickurls" ".recentf" ".redcar" ".rspec" ".sass-cache" ".scala_dependencies" ".shadow_todo" ".shadows" ".strokes" ".svn" ".timelog" ".todo-do" ".todo-done" ".todo-top" ".tox" ".type-break" ".vip" ".viper" ".wmncach.el" ".yardoc" "_MTN" "__history" "_bdfcache.el" "_build" "_cgo_defun.c" "_cgo_gotypes.go" "_darcs" "_obj" "_sgbak" "_site" "_test" "_testmain.go" "_yardoc" "aclocal.m4" "auto-save-list" "autom4te.cache" "bin-debug" "bin-release" "blib" "build" "Build" "Build.bat" "COMMIT_EDITMSG" "cmake_install.cmake" "CMakeCache.txt" "CMakeFiles" "cover_db" "cscope.csd" "cscope.files" "cscope.inc" "cscope.lst" "cscope.out" "cscope.out.po" "cscope.tmplist" "CVS" "Debug" "debug" "depcomp" "DerivedData" "Desktop.ini" "ehthumbs.db" "GHI_ISSUE" "git-rebase-todo" "gwt-unitCache" "gwt_bree" "install-sh" "install_manifest.txt" "InstalledFiles" "Makefile.in" "Makefile.old" "MCVS" "META.yml" "MERGE_MSG" "minimal-session-saver-data.el" "MYMETA.yml" "nbbuild" "nbdist" "nosetests.xml" "nytprof" "nytprof.out" "perltidy.ERR" "pm_to_blib" "Profile" "profile" "RCS" "Release" "release" "SCCS" "Session.vim" "slprj" "SQUASH_MSG" "TAGS" "TAG_EDITMSG" "tags" "TestResult" "testresult" "Thumbs.db" "tmtags" "xcuserdata" "xhtml-loader.rnc" "{arch}" "~.dep" "~.dot" "~.nib" "~.plst" "test.out" "test_out" "test.output" "test_output" "node_modules" "bower_components")))
 '(indicate-empty-lines nil)
 '(jabber-account-list
   (quote
    (("emallson@atlanis.net"
      (:network-server . "talk.google.com")
      (:port . 5222)
      (:connection-type . ssl)))))
 '(js2-concat-multiline-strings (quote eol))
 '(js2-global-externs (quote ("describe" "it")))
 '(js2-include-node-externs t)
 '(js2-mode-show-strict-warnings nil)
 '(linum-format "%3d ")
 '(markdown-enable-math t)
 '(menu-bar-mode nil)
 '(merlin-command "/usr/bin/ocamlmerlin")
 '(merlin-use-auto-complete-mode nil)
 '(mpc-browser-tags (quote (Artist|Composer|Performer Album|Playlist)))
 '(mu4e-change-filenames-when-moving t)
 '(mu4e-completing-read-function (quote helm--completing-read-default))
 '(mu4e-compose-dont-reply-to-self t)
 '(mu4e-compose-signature-auto-include nil)
 '(mu4e-confirm-quit nil)
 '(mu4e-get-mail-command "mbsync -aq")
 '(mu4e-headers-include-related t)
 '(mu4e-headers-results-limit 200)
 '(mu4e-headers-skip-duplicates t)
 '(mu4e-user-mail-address-list
   (quote
    ("emallson@archlinux.us" "emallson@cs.uky.edu" "emallson@atlanis.net" "emallson@ufl.edu" "jdsmith@cise.ufl.edu" "aemallson@uky.edu")))
 '(mu4e-view-prefer-html t)
 '(mu4e-view-show-addresses t)
 '(mu4e-view-show-images t)
 '(org-agenda-files (quote ("~/org/work.org")))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (sh . t) (dot . t) (python . t))))
 '(org-babel-tangle-lang-exts (quote (("emacs-lisp" . "el") ("clojure" . "clj"))))
 '(org-capture-templates
   (quote
    (("h" "Thought" item
      (file+headline "~/org/notes.org" "Thoughts")
      ""))))
 '(org-clock-idle-time 30)
 '(org-clock-in-resume t)
 '(org-clock-into-drawer t)
 '(org-confirm-babel-evaluate nil)
 '(org-display-custom-times t)
 '(org-drawers
   (quote
    ("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "CONTEXT" "HIDDEN")))
 '(org-export-allow-bind-keywords t)
 '(org-export-date-timestamp-format "%d %B %Y")
 '(org-export-html-protect-char-alist (quote (("<" . "&lt;") (">" . "&gt;"))))
 '(org-export-latex-default-packages-alist
   (quote
    (("AUTO" "inputenc" t)
     ("T1" "fontenc" t)
     ("" "fixltx2e" nil)
     ("" "graphicx" t)
     ("" "longtable" nil)
     ("" "float" nil)
     ("" "wrapfig" nil)
     ("" "soul" t)
     ("" "textcomp" t)
     ("" "marvosym" t)
     ("" "wasysym" t)
     ("" "latexsym" t)
     ("" "amssymb" t)
     ("" "hyperref" nil)
     "\\tolerance=1000"
     ("" "amsmath" t))))
 '(org-export-latex-minted-langs
   (quote
    ((emacs-lisp "common-lisp")
     (cc "c++")
     (cperl "perl")
     (shell-script "bash")
     (caml "ocaml")
     (clojure "clojure"))))
 '(org-export-pdf-logfiles
   (quote
    ("aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "blg" "pyg")))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-html-htmlize-output-type (quote css))
 '(org-html-postamble nil)
 '(org-html-preamble-format (quote (("en" "<h4>Last Modified: %C</h4>"))))
 '(org-inline-image-background "#fdf6e3")
 '(org-latex-default-packages-alist
   (quote
    (("AUTO" "inputenc" t)
     ("T1" "fontenc" t)
     ("" "fixltx2e" nil)
     ("" "graphicx" t)
     ("" "longtable" nil)
     ("" "float" nil)
     ("" "wrapfig" nil)
     ("" "rotating" nil)
     ("normalem" "ulem" t)
     ("" "amsmath" t)
     ("" "textcomp" t)
     ("" "marvosym" t)
     ("" "wasysym" t)
     ("" "amssymb" t)
     ("" "hyperref" nil)
     "\\tolerance=1000"
     ("" "lmodern" nil))))
 '(org-latex-listings (quote minted))
 '(org-latex-logfiles-extensions
   (quote
    ("aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "bbl" "blg" "pyg")))
 '(org-latex-minted-langs
   (quote
    ((emacs-lisp "common-lisp")
     (cc "c++")
     (cperl "perl")
     (shell-script "bash")
     (caml "ocaml")
     (ipython "python"))))
 '(org-latex-packages-alist (quote (("" "minted" nil) ("margin=1in" "geometry" nil))))
 '(org-latex-pdf-process
   (quote
    ("pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" "biber %b" "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f")))
 '(org-latex-to-pdf-process
   (quote
    ("pdflatex -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f")))
 '(org-list-demote-modify-bullet (quote (("-" . "+") ("+" . "*") ("*" . "+"))))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(org-pretty-entities t)
 '(org-pretty-entities-include-sub-superscripts nil)
 '(org-src-fontify-natively t)
 '(org-src-lang-modes
   (quote
    (("racket" . scheme)
     ("ocaml" . tuareg)
     ("elisp" . emacs-lisp)
     ("ditaa" . artist)
     ("asymptote" . asy)
     ("sqlite" . sql)
     ("calc" . fundamental)
     ("C" . c)
     ("cpp" . c++)
     ("C++" . c++)
     ("screen" . shell-script)
     ("js" . js2)
     ("dot" . graphviz-dot))))
 '(org-src-window-setup (quote other-window))
 '(org-time-stamp-custom-formats (quote ("<%a, %d %B %Y>" . "<%a, %d %B %Y at %H:%M>")))
 '(org-todo-keywords (quote ((sequence "TODO" "DOING" "|" "DONE" "FAIL"))))
 '(package-archives
   (quote
    (("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("e6h" . "http://www.e6h.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/")
     ("org" . "http://orgmode.org/elpa/"))))
 '(package-pinned-packages (quote ((twittering-mode . "melpa"))))
 '(paradox-automatically-star nil)
 '(paradox-github-token t)
 '(pixie-inf-lisp-program "~/Code/pixie/pixie-vm")
 '(projectile-completion-system (quote helm))
 '(projectile-enable-idle-timer t)
 '(projectile-globally-ignored-buffers (quote ("*scratch*")))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" "build" "venv" "virtualenv" "node_modules" "ppm-venv" "bower_components")))
 '(projectile-globally-ignored-files (quote ("TAGS" "*.min.css")))
 '(projectile-go-function (lambda (&rest r) nil))
 '(projectile-tags-command "ctags -Re -f \"%s\" %s")
 '(projectile-test-suffix-function (quote projectile-custom-test-suffix))
 '(prolog-system (quote swi))
 '(quack-fontify-style (quote emacs))
 '(rainbow-identifiers-choose-face-function (quote rainbow-identifiers-cie-l*a*b*-choose-face))
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 25)
 '(rainbow-identifiers-faces-to-override
   (quote
    (js2-function-call js2-function-param js2-external-variable font-lock-variable-name-face font-lock-function-name-face default)))
 '(reb-re-syntax (quote string))
 '(recentf-max-menu-items 100)
 '(recentf-max-saved-items 100)
 '(ropemacs-guess-project t)
 '(safe-local-variable-values
   (quote
    ((flycheck-clang-language-standard)
     (pyvenv-activate . /home/emallson/\.anaconda3/envs/gray-bird/)
     (geiser-scheme-implementation . "guile")
     (semantic-dependency-system-include-path
      (quote
       ("/usr/include" "/usr/lib/gcc/x86_64-unknown-linux-gnu/5.3.0/include/" "/usr/local/include/" "/usr/lib/gcc/x86_64-unknown-linux-gnu/5.3.0/include-fixed/" "/usr/include/" "/usr/include/guile/2.0/")))
     (flycheck-mode)
     (pyvenv-activate . "./venv/")
     (org-babel-use-quick-and-dirty-noweb-expansion . t)
     (org-latex-pdf-process "pdflatex -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f")
     (org-latex-pdf-process "pdflatex -interaction nonstopmode %o %f" "bibtex %b" "pdflatex -interaction nonstopmode %o %f" "pdflatex -interaction nonstopmode %o %f")
     (org-src-preserve-indentation . t)
     (pyvenv-activate . "~/Code/CrossTraining/venv")
     (pyvenv-activate . "./venv")
     (require-final-newline))))
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(sentence-end-double-space nil)
 '(show-paren-mode nil)
 '(show-trailing-whitespace nil)
 '(shr-color-visible-distance-min 20)
 '(shr-color-visible-luminance-min 80)
 '(sml/mode-width 5)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(sp-base-key-bindings (quote paredit))
 '(sp-highlight-pair-overlay nil)
 '(sp-highlight-wrap-overlay nil)
 '(sp-highlight-wrap-tag-overlay nil)
 '(sp-hybrid-kill-entire-symbol (quote sp-point-in-string))
 '(sp-override-key-bindings
   (quote
    ((")" . sp-up-sexp)
     ("]" . sp-up-sexp)
     ("}" . sp-up-sexp))))
 '(sublimity-scroll-drift-length 6)
 '(tab-stop-list
   (cl-loop with i = 0 do
            (setf i
                  (+ i 4))
            until
            (= i 120)
            collect i))
 '(tab-width 4)
 '(tags-add-tables nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(twittering-use-icon-storage t)
 '(twittering-use-master-password t)
 '(undo-tree-auto-save-history t)
 '(undo-tree-history-directory-alist (quote (("." . "~/.emacs.d/.undo-tree/"))))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(use-package-verbose t)
 '(utop-command "utop -emacs")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(web-mode-auto-close-style 2)
 '(web-mode-code-indent-offset 4)
 '(web-mode-enable-auto-pairing t)
 '(web-mode-enable-auto-quoting nil)
 '(web-mode-markup-indent-offset 2)
 '(whitespace-global-modes (quote (not erc-mode magit-mode)))
 '(winner-boring-buffers
   (quote
    ("*Completions*" "*helm M-x*" "*helm mini*" "*Helm Find Files*")))
 '(winner-mode t)
 '(writeroom-major-modes (quote (markdown-mode)))
 '(znc-servers
   (quote
    (("atlanis.net" 6464 t
      ((freenode "emallson" nil)))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#202020" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "adobe" :family "Source Code Pro"))))
 '(company-tooltip-annotation ((t (:inherit company-tooltip-common))))
 '(company-tooltip-common ((t (:background "#303030" :foreground "#9FBF9F"))))
 '(company-tooltip-common-selection ((t (:background "#2A2A2A" :foreground "#9FBF9F"))))
 '(highlight ((t (:background "#202020" :foreground "#ececdc" :weight bold))))
 '(linum ((t (:background "#202020" :foreground "#9FBF9F" :underline nil))))
 '(mode-line ((t (:background "#202020" :foreground "#8FB28F" :box nil))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#383838" :foreground "#5F7F5F" :box nil :weight light))))
 '(org-checkbox ((t (:inherit bold :background "#202020" :foreground "#ECECDC" :box nil))))
 '(shm-current-face ((t (:background "#303030"))))
 '(sml/battery ((t (:inherit sml/global :foreground "#E0CF9F"))) t)
 '(sml/discharging ((t (:inherit sml/global :foreground "#E0CF9F")))))
