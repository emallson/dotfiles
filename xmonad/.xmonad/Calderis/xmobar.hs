Config { commands = [  Run Battery [] 600
                     , Run Date "%H:%M on %d %B %Y" "date" 600
                     , Run StdinReader
                     , Run Mail [("school ", "~/Mail/emallson@ufl.edu/INBOX")
                                ,("cise ", "~/Mail/jdsmith@cise.ufl.edu/INBOX")
                                ,("gmail ", "~/Mail/emallson@archlinux.us/INBOX")
                                ,("atlanis ", "~/Mail/emallson@atlanis.net/INBOX")] "mail"
                     , Run MPD ["-t"
                               ,"<state>: <title>, <artist> (<album>) [<lapsed>/<length>]"] 10
                     , Run DiskU [("/", "<used>/<size>"), ("/home", "<used>/<size>")]
                                 ["-L", "50", "-H", "75", "-m", "1", "-p", "3",
                                  "--normal", "#F0DFAF", "--high", "#CC9393", "--low", "#7F9F7F"] 20
                     , Run Network "eth0" ["-S", "True", "-t", "<dev>: <rx> / <tx>"] 20
                     ]
        , template = "%StdinReader% | %disku% } %mpd% { %mail% | %date%"
        , bgColor = "#202020"
        , position = Bottom
        , alignSep = "}{"
        , font = "xft:Source Code Pro Regular:size=9:antialias=true"
        , allDesktops = True
        , lowerOnStart = False}
