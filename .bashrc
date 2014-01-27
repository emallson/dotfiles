#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -B'
alias clip='xclip -sel clip'
alias em='emacsclient -c -a "" -nw'
export PATH=~/.root/bin:$PATH:/opt/bin:~/Code/node_modules/.bin
export MPD_HOST=vorringia.atl
export EDITOR=new-emacs VISUAL=new-emacs ALTERNATE_EDITOR=emacs
export CHROME_BIN=chromium
export GLOBIGNORE=".:.."

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PREFIX="$HOSTNAME:"
else
    PREFIX=""
fi

function display_git_branch() {
    branch=$(git branch 2> /dev/null | grep "*" | cut -d\  -f2- 2> /dev/null);
    if [[ -n "$branch" ]]; then
        echo " ($branch)"
    fi
}

PS1='[\j \A $PREFIX\w$(display_git_branch)]\$ '

source /usr/share/git/completion/git-completion.bash
