#!/bin/bash

entry="$(gpg2 -q --for-your-eyes-only --no-tty -d ~/.authinfo.gpg | grep "machine $1" | grep "port $2" | grep "login $3")"

if [[ "$4" == "password" ]]; then
    echo $entry | sed -n -e 's/^.*password "\([^"]*\)".*$/\1/p'
else
    echo $entry | sed -n -e "s/^.*$3 \\([^ ]*\\).*$/\\1/p"
fi
