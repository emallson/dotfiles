#!/bin/bash
set -e
FMT='%artist% - %album% - %title%'
track=`mpd-rotate.sh | dmenu -i -l 6 -p "Play Next: "`
TARGET=`mpc -f "$FMT" playlist | grep -Fxn "$track" | cut -f1 -d: | head -n1`
CURRENT=`mpc playlist | grep -Fxn "$(mpc current)" | cut -f1 -d:`

if [[ -n "$TARGET" ]]; then
   mpc move $TARGET $(($CURRENT + 1))
fi
