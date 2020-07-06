#!/usr/bin/env zsh
setopt extendedglob
stow ^(TAGS|root|config.h|$(basename $0))
#sudo stow root -t /
