#!/bin/sh
setxkbmap us
xmodmap -e "remove Mod1 = Alt_R"
xmodmap -e "add Mod3 = Alt_R"
