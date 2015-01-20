Config { commands = [ Run Wireless "wlp3s0" ["-t", "<essid> <quality>"
                                            ,"-n", "#F0DFAF"
                                            ,"-h", "#7F9F7F"
                                            ,"-l", "#CC9393"]
                           100
                    , Run Battery [] 600
                    , Run Date "%H:%M on %d %B" "date" 600
                    , Run StdinReader
                    , Run MPD ["-t"
                              ,"<state>: <title>, <artist> (<album>) [<lapsed>/<length>]"] 10
                    , Run DiskU [("/", "<used>/<size>"), ("/home", "<used>/<size>")]
                                ["-L", "50", "-H", "75", "-m", "1", "-p", "3",
                                 "--normal", "#F0DFAF", "--high", "#CC9393", "--low", "#7F9F7F"] 20
                    ]
       , template = "%StdinReader% | %disku% } %mpd% { %wlp3s0wi% | %battery% | %date%"
       , bgColor = "#202020"
       , position = Bottom
       , alignSep = "}{"
       , font = "xft:Source Code Pro light:size=9:antialias=true"
       , allDesktops = True}
