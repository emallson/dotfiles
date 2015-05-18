(add-to-list 'modules:el-get-packages 'emms)

(eval-after-load 'emms-setup
  '(progn
     (emms-all)
     (emms-default-players)
     (add-to-list 'emms-info-functions 'emms-info-mpd)
     (add-to-list 'emms-player-list 'emms-player-mpd)))
