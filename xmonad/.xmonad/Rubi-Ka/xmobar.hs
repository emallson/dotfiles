Config { commands = [ Run Com "netctl-auto" ["current"] "wifi-profile" 600
                    , Run Wireless "wlp3s0" ["-t", "<quality>"
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
       , template = "%StdinReader% | %disku% } %mpd% { %wifi-profile% %wlp3s0wi% | %battery% | %date%"
       , bgColor = "#202020"
       , position = Bottom
       , alignSep = "}{"
       , font = "xft:Source Code Pro:size=9:antialias=true"
       , allDesktops = True}
