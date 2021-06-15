#!/usr/bin/env zsh
setopt extendedglob
stow ^(TAGS|config.h|$(basename $0))
