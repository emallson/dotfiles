#!/bin/bash
set -e
FMT='%artist% - %album% - %title%'
idx=`mpc playlist | grep -Fxn "$(mpc current)" | cut -f1 -d:`

cat <(mpc -f "$FMT" playlist | tail -n +$idx) <(mpc -f "$FMT" playlist | head -n $(($idx - 1)))
