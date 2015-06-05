Config { commands = [  Run Battery [] 600
                     , Run Date "%H:%M on %d %B %Y" "date" 600
                     , Run StdinReader
                     , Run DiskU [("/", "<used>/<size>"), ("/home", "<used>/<size>")]
                                 ["-L", "50", "-H", "75", "-m", "1", "-p", "3",
                                  "--normal", "#F0DFAF", "--high", "#CC9393", "--low", "#7F9F7F"] 20
                     ]
        , template = "%StdinReader% | %disku% } { %battery% | %date%"
        , bgColor = "#202020"
        , position = Bottom
        , alignSep = "}{"
        , font = "xft:Source Code Pro Regular:size=9:antialias=true"
        , allDesktops = True
        , lowerOnStart = False}
