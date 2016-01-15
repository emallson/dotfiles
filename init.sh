#!/usr/bin/env zsh
setopt extendedglob
stow ^(root|$(basename $0))
sudo stow root -t /
