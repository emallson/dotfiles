source .zsh.d/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle git-flow-avh
antigen bundle lein
antigen bundle emallson/gulp-zsh-completion

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle autojump

antigen theme gallois

antigen apply

export PATH="$HOME/.root/bin:$HOME/bin:/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='new-emacs'
else
  export EDITOR='emacs'
fi

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
alias na='sudo netctl-auto'

alias start='sudo systemctl start'
alias restart='sudo systemctl restart'
alias stop='sudo systemctl stop'

alias em='emacsclient'

# OPAM configuration
. /home/emallson/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export NVM_DIR="/home/emallson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Cabal config
export PATH="$HOME/.cabal/bin:$PATH"

# export PATH user units -- mostly emacs
syus import-environment PATH
