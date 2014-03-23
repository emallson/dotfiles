#!/bin/bash

if [[ $1 == "out" ]]; then
    rsync -avz --exclude-from=excludes ./ ~/;
    echo;
elif [[ $1 == "in" ]]; then
    rsync -avz --existing --delete --exclude-from=excludes ~/ ./;
elif [[ $1 == "add" ]]; then
    CWD=$(pwd);
    cd ~;
    cp --parents "${2#$HOME/}" "${CWD}/";
    cd $CWD;
    git add "${2#$HOME/}";
fi

