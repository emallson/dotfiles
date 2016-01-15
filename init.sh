#!/usr/bin/env zsh
setopt extendedglob
stow ^(TAGS|root|$(basename $0))
sudo stow root -t /
