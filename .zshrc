# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gallois"

DEFAULT_USER="emallson"

plugins=(git zsh-syntax-highlighting autojump)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/.root/bin:$HOME/bin:/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='new-emacs'
else
  export EDITOR='emacs'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

alias ls='ls --color=auto -B'

setopt extendedglob

function uva() {
    g++ -g -lm -lcrypt -O2 -pipe -DONLINE_JUDGE $1 -o $(echo $1 | rev | cut -d. -f2- | rev)
}
function uva-11() {
    g++ -g -std=c++11 -lm -lcrypt -O2 -pipe -DONLINE_JUDGE $1 -o $(echo $1 | rev | cut -d. -f2- | rev)
}
export CHROME_BIN=chromium;
alias rs="redshift -l 38:-85"
alias syus="systemctl --user"
