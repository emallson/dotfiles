#!/bin/bash
mpc findadd $1 "$(mpc list $1 | dmenu -i -l 6 -p "${1^} ")"
