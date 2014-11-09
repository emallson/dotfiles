Config { commands = [ Run Date "%H:%M on %d %B %Y" "date" 50
                    , Run StdinReader
                    , Run MPD ["-t"
                              ,"<state>: <title>, <artist> (<album>) [<lapsed>/<length>]"] 10]
       , template = "%StdinReader% } %mpd% { %date%"
       , bgColor = "#202020"
       , position = Bottom
       , alignSep = "}{"
       , font = "xft:Source Code Pro light:size=9:antialias=true"
       , allDesktops = True}
