#!/bin/bash
TARGET="$(mpc list $1 | dmenu -i -l 6 -p "${1^} " | head -n1)"

if [[ -n "$TARGET" ]]; then
    mpc findadd $1 "$TARGET"
fi
