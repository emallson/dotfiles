#!/bin/bash
if [[ -z "$(setxkbmap -print | grep colemak)" ]]; then
    ~/.xmonad/to-colemak.sh
else
    ~/.xmonad/to-qwerty.sh
fi
