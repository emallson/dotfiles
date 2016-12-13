#!/bin/bash
set -e
FMT='%artist% - %album% - %title%'
track=`mpc -f "$FMT" playlist | dmenu -i -l 6 -p "Play: "`
TARGET=`mpc -f "$FMT" playlist | grep -F -n "$track" | cut -f1 -d: | head -n1`
echo $TARGET

if [[ -n "$TARGET" ]]; then
   mpc play $TARGET
fi
