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
 '(browse-url-browser-function (quote browse-url-firefox))
 '(comment-auto-fill-only-comments t)
 '(compilation-read-command nil)
 '(create-lockfiles nil)
 '(custom-safe-themes
   (quote
    ("3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "3a9ff11d1337a00ca267f1d94dd4a8cdcee083014a9ef13d6c25bb11a9eac199" "e88e253e38a442679ebd43cbd75d56f0659f568881cb6977527f0b0bd7e03080" "b621af558778c09cd767d8bc3923552b1066cad5f398fb3ed6abf029dde69ffa" "3090af8bd70378df5c78fdcbdf20539eaccac7d0f3d948bd0f0a3245e59b82bc" "e5e0e4e20697cd7c2a8ab900246db214241a826d5348e0cd943b0aadc57d6170" "26cec1daa06ecf8191983cfbe8a4b33115529111093c7d4b3b19b37e2c54c625" "729372c7d16866ab00ae494ebcd9f5c9f91477e0adffec585e170bdab107361c" "5d65ef430d457bcf697f2dc2c3de3f270a7b6709f48cc96184dc286b84805240" "a14fa334282295971b68538b2d64593472a5dd09534dd48f3db748e534d10377" "9fc8b10d1bb9ff26507114013a9283c49ac1e09a5b67a12755ec67bedb18fc98" "6bbe1f9067adbc38752fc2b1e9ead7b660b0fc92034a52cb09843413ecd311ed" "1c2253db4f3c34e54cad751372ba54c0eb114fb7f6a4a4fb9c44d1f250bf5416" "22b0cb305c407fe7220501c46e0bc36c34dc10138f8c61dee72079340cd838f5" "3c7d756bfd56e4fe67baecbe1e972fea7c5374b7457839d179e73823d6d9f2ac" default)))
 '(display-battery-mode t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(edit-server-new-frame nil)
 '(erc-auto-set-away nil)
 '(erc-autojoin-channels-alist
   (quote
    (("freenode" "#emacs" "#evil-mode" "#hoplon" "#haskell" "#xmonad" "#clojure"))))
 '(erc-autojoin-timing (quote ident))
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring services stamp track)))
 '(erc-nick "Atlanis")
 '(erc-prompt-for-nickserv-password nil)
 '(erc-prompt-for-password nil)
 '(evil-want-fine-undo t)
 '(fci-rule-color "#383838")
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(fortran-minimum-statement-indent-fixed 8)
 '(fringe-mode 0 nil (fringe))
 '(gnus-init-file "~/.emacs.d/gnus.el")
 '(grep-find-ignored-directories
   (quote
    ("$RECYCLE.BIN" ".AppleDouble" ".DS_Store" ".DocumentRevisions-V100" ".LSOverride" ".Rhistory" ".Spotlight-V100" ".TemporaryItems" ".Trashes" ".actionScriptProperties" ".apt_generated" ".bdfcache.el" ".build" ".buildpath" ".builds" ".bzr" ".cdv" ".classpath" ".com.apple.timemachine.donotpresent" ".com.apple.timemachine.supported" ".coverage" ".cproject" ".directory" ".dropbox" ".dropbox.cache" ".emacs-places" ".emacs.desktop" ".emacs.desktop.lock" ".eunit" ".externalToolBuilders" ".flexProperties" ".fseventsd" ".git" ".hg" ".idea" ".idlwave" ".ido.last" ".kkcrc" ".last_cover_stats" ".lein-deps-sum" ".loadpath" ".netrwhist" ".notes" ".org-id-locations" ".pc" ".project" ".projectile" ".prove" ".puppet-bak" ".quickurls" ".recentf" ".redcar" ".rspec" ".sass-cache" ".scala_dependencies" ".shadow_todo" ".shadows" ".strokes" ".svn" ".timelog" ".todo-do" ".todo-done" ".todo-top" ".tox" ".type-break" ".vip" ".viper" ".wmncach.el" ".yardoc" "_MTN" "__history" "_bdfcache.el" "_build" "_cgo_defun.c" "_cgo_gotypes.go" "_darcs" "_obj" "_sgbak" "_site" "_test" "_testmain.go" "_yardoc" "aclocal.m4" "auto-save-list" "autom4te.cache" "bin-debug" "bin-release" "blib" "build" "Build" "Build.bat" "COMMIT_EDITMSG" "cmake_install.cmake" "CMakeCache.txt" "CMakeFiles" "cover_db" "cscope.csd" "cscope.files" "cscope.inc" "cscope.lst" "cscope.out" "cscope.out.po" "cscope.tmplist" "CVS" "Debug" "debug" "depcomp" "DerivedData" "Desktop.ini" "ehthumbs.db" "GHI_ISSUE" "git-rebase-todo" "gwt-unitCache" "gwt_bree" "install-sh" "install_manifest.txt" "InstalledFiles" "Makefile.in" "Makefile.old" "MCVS" "META.yml" "MERGE_MSG" "minimal-session-saver-data.el" "MYMETA.yml" "nbbuild" "nbdist" "nosetests.xml" "nytprof" "nytprof.out" "perltidy.ERR" "pm_to_blib" "Profile" "profile" "RCS" "Release" "release" "SCCS" "Session.vim" "slprj" "SQUASH_MSG" "TAGS" "TAG_EDITMSG" "tags" "TestResult" "testresult" "Thumbs.db" "tmtags" "xcuserdata" "xhtml-loader.rnc" "{arch}" "~.dep" "~.dot" "~.nib" "~.plst" "test.out" "test_out" "test.output" "test_output" "doc" "coverage")))
 '(haskell-process-type (quote cabal-repl))
 '(helm-buffers-fuzzy-matching t)
 '(helm-ff-auto-update-initial-value t)
 '(helm-ff-skip-boring-files t)
 '(helm-quick-update t)
 '(ignoramus-file-basename-endings
   (quote
    (".386" ".a" ".acn" ".acr" ".alg" ".ap_" ".apk" "_archive" ".asv" "-autoloads.el" ".aux" ".bak" ".bbl" ".beam" ".bin" ".blg" ".cgo1.go" ".cgo2.c" ".chi" ".chi.h" ".class" ".com" ".cp" ".cps" ".d64fsl" ".dcu" ".dep" ".dex" ".dfsl" ".dll" ".drc" ".drv" ".dvi" ".dx32fsl" ".dx64fsl" ".dxl" ".dylib" ".ear" ".elc" ".esproj" "-Ex.R" ".exe" ".fas" ".fasl" ".fdb_latexmk" ".fmx" ".fn" ".fns" ".fsl" ".fx32fsl" ".fx64fsl" ".gcda" ".gcno" ".gcov" ".glg" ".glo" ".gls" ".gmo" ".hi" ".identcache" ".ilg" ".ilk" ".iml" ".ind" ".ipr" ".ist" ".iws" ".jar" ".ky" ".kys" ".la" ".lai" ".launch" ".lbin" ".lib" ".lnk" ".lo" ".lock" ".lof" ".lot" ".lx32fsl" ".lx64fsl" ".maf" ".mem" ".min.js" "-min.js" ".min.css" "-min.css" ".mmx" ".mo" ".moved-aside" ".mtc" ".mtc0" ".nav" ".nlo" ".o" ".obj" ".opensdf" ".orig" ".p64fsl" ".pdfsync" ".pfsl" ".pg" ".pgs" ".pid" ".pidb" ".plt" ".plx" ".pot" ".psess" ".Publish.xml" ".pyc" ".pyd" ".pydevproject" ".pyo" ".rbc" ".rej" ".sassc" ".scc" ".sdf" ".seed" ".sln.docstates" ".slo" ".snm" ".so" ".sparcf" ".sublime-project" ".sublime-workspace" ".suo" ".swo" ".swp" ".sx32fsl" ".sx64fsl" ".synctex.gz" ".ttc" ".tfm" ".tmproj" ".tmproject" ".toc" ".tp" ".tps" ".ufsl" ".un~" ".vr" ".vrb" ".vrs" ".vsp" ".vspscc" ".vssscc" ".vxd" ".war" ".wx32fsl" ".wx64fsl" ".x86f" ".xdy" ".zwc" "~")))
 '(ignoramus-file-basename-exact-names
   (quote
    ("$RECYCLE.BIN" ".AppleDouble" ".DS_Store" ".DocumentRevisions-V100" ".LSOverride" ".Rhistory" ".Spotlight-V100" ".TemporaryItems" ".Trashes" ".actionScriptProperties" ".apt_generated" ".bdfcache.el" ".build" ".buildpath" ".builds" ".bzr" ".cdv" ".classpath" ".com.apple.timemachine.donotpresent" ".com.apple.timemachine.supported" ".coverage" ".cproject" ".directory" ".dropbox" ".dropbox.cache" ".emacs-places" ".emacs.desktop" ".emacs.desktop.lock" ".eunit" ".externalToolBuilders" ".flexProperties" ".fseventsd" ".git" ".hg" ".idea" ".idlwave" ".ido.last" ".kkcrc" ".last_cover_stats" ".lein-deps-sum" ".loadpath" ".netrwhist" ".notes" ".org-id-locations" ".pc" ".project" ".projectile" ".prove" ".puppet-bak" ".quickurls" ".recentf" ".redcar" ".rspec" ".sass-cache" ".scala_dependencies" ".shadow_todo" ".shadows" ".strokes" ".svn" ".timelog" ".todo-do" ".todo-done" ".todo-top" ".tox" ".type-break" ".vip" ".viper" ".wmncach.el" ".yardoc" "_MTN" "__history" "_bdfcache.el" "_build" "_cgo_defun.c" "_cgo_gotypes.go" "_darcs" "_obj" "_sgbak" "_site" "_test" "_testmain.go" "_yardoc" "aclocal.m4" "auto-save-list" "autom4te.cache" "bin-debug" "bin-release" "blib" "build" "Build" "Build.bat" "COMMIT_EDITMSG" "cmake_install.cmake" "CMakeCache.txt" "CMakeFiles" "cover_db" "cscope.csd" "cscope.files" "cscope.inc" "cscope.lst" "cscope.out" "cscope.out.po" "cscope.tmplist" "CVS" "Debug" "debug" "depcomp" "DerivedData" "Desktop.ini" "ehthumbs.db" "GHI_ISSUE" "git-rebase-todo" "gwt-unitCache" "gwt_bree" "install-sh" "install_manifest.txt" "InstalledFiles" "Makefile.in" "Makefile.old" "MCVS" "META.yml" "MERGE_MSG" "minimal-session-saver-data.el" "MYMETA.yml" "nbbuild" "nbdist" "nosetests.xml" "nytprof" "nytprof.out" "perltidy.ERR" "pm_to_blib" "Profile" "profile" "RCS" "Release" "release" "SCCS" "Session.vim" "slprj" "SQUASH_MSG" "TAGS" "TAG_EDITMSG" "tags" "TestResult" "testresult" "Thumbs.db" "tmtags" "xcuserdata" "xhtml-loader.rnc" "{arch}" "~.dep" "~.dot" "~.nib" "~.plst" "test.out" "test_out" "test.output" "test_output" "node_modules")))
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
 '(menu-bar-mode nil)
 '(merlin-command "/usr/bin/ocamlmerlin")
 '(merlin-use-auto-complete-mode nil)
 '(mpc-browser-tags (quote (Artist|Composer|Performer Album|Playlist)))
 '(mu4e-compose-signature-auto-include nil)
 '(mu4e-view-prefer-html t)
 '(mu4e-view-show-addresses t)
 '(mu4e-view-show-images t)
 '(nodejs-repl-command "~/.nvm/current/bin/node")
 '(org-agenda-files (quote ("~/org/wow.org" "~/org/uky.org")))
 '(org-babel-tangle-lang-exts (quote (("emacs-lisp" . "el") ("clojure" . "clj"))))
 '(org-display-custom-times t)
 '(org-drawers
   (quote
    ("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "CONTEXT" "HIDDEN")))
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
     ("" "microtype" nil)
     ("" "lmodern" nil)
     ("" "minted" t))))
 '(org-latex-listings (quote minted))
 '(org-latex-logfiles-extensions
   (quote
    ("aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "bbl" "blg" "pyg")))
 '(org-latex-pdf-process
   (quote
    ("pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f" "pdflatex --shell-escape -interaction nonstopmode -output-directory %o %f")))
 '(org-latex-to-pdf-process
   (quote
    ("pdflatex -interaction nonstopmode -output-directory %o %f" "bibtex %b" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f")))
 '(org-list-demote-modify-bullet (quote (("-" . "+") ("+" . "*") ("*" . "+"))))
 '(org-src-fontify-natively t)
 '(org-src-lang-modes
   (quote
    (("ocaml" . tuareg)
     ("elisp" . emacs-lisp)
     ("ditaa" . artist)
     ("asymptote" . asy)
     ("dot" . fundamental)
     ("sqlite" . sql)
     ("calc" . fundamental)
     ("C" . c)
     ("cpp" . c++)
     ("C++" . c++)
     ("screen" . shell-script)
     ("js" . js2))))
 '(org-tags-column -115)
 '(org-time-stamp-custom-formats (quote ("<%a, %d %B %Y>" . "<%a, %d %B %Y at %H:%M>")))
 '(org-todo-keywords (quote ((sequence "TODO" "DOING" "|" "DONE" "FAIL"))))
 '(package-archives
   (quote
    (("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("e6h" . "http://www.e6h.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(package-pinned-packages (quote ((twittering-mode . "melpa"))))
 '(paradox-automatically-star nil)
 '(paradox-github-token t t)
 '(projectile-completion-system (quote helm))
 '(projectile-enable-idle-timer t)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" "build" "venv" "virtualenv" "node_modules")))
 '(projectile-globally-ignored-files (quote ("TAGS" "*.min.css")))
 '(projectile-test-suffix-function (quote projectile-custom-test-suffix))
 '(reb-re-syntax (quote string))
 '(ropemacs-guess-project t)
 '(safe-local-variable-values (quote ((require-final-newline))))
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(show-trailing-whitespace nil)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(sp-autoescape-string-quote nil)
 '(sp-highlight-pair-overlay nil)
 '(sp-highlight-wrap-overlay nil)
 '(sp-highlight-wrap-tag-overlay nil)
 '(sp-hybrid-kill-entire-symbol (quote sp-point-in-string))
 '(sp-hybrid-kill-excessive-whitespace nil)
 '(sublimity-scroll-drift-length 6)
 '(tab-stop-list
   (loop with i = 0 do
         (setf i
               (+ i 4))
         until
         (= i 120)
         collect i))
 '(tab-width 4)
 '(tags-add-tables nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(undo-tree-auto-save-history t)
 '(undo-tree-history-directory-alist (quote (("." . "~/.emacs.d/.undo-tree/"))))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
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
 '(web-mode-code-indent-offset 4)
 '(web-mode-enable-auto-pairing t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-annotation ((t (:inherit company-tooltip-common))))
 '(company-tooltip-common ((t (:background "#303030" :foreground "#9FBF9F"))))
 '(company-tooltip-common-selection ((t (:background "#2A2A2A" :foreground "#9FBF9F"))))
 '(italic ((t (:slant italic))))
 '(mode-line ((t (:background "#202020" :foreground "#8FB28F" :box nil))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#383838" :foreground "#5F7F5F" :box nil :weight light))))
 '(org-checkbox ((t (:inherit bold :background "#202020" :foreground "#ECECDC" :box nil))))
 '(shm-current-face ((t (:background "#303030"))) t)
 '(sml/battery ((t (:inherit sml/global :foreground "#E0CF9F"))) t)
 '(sml/discharging ((t (:inherit sml/global :foreground "#E0CF9F")))))
