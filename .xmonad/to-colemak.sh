#!/bin/sh
setxkbmap us -variant colemak
xmodmap -e "keycode 0x6c = Alt_R"
xmodmap -e "add Mod3 = Alt_R"
