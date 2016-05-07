#!/bin/bash
TARGET="$(mpc playlist | grep -F -n "$(mpc playlist | dmenu -i -l 6 -p "Play: ")" | cut -f1 -d: | head -n1)"

echo $TARGET

if [[ -n "$TARGET" ]]; then
   mpc play $TARGET
fi
