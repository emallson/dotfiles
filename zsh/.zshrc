unset GREP_OPTIONS;

source ~/.zsh.d/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle git-flow-avh
antigen bundle lein
antigen bundle emallson/gulp-zsh-completion

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle autojump
antigen bundle safe-paste       # todo: patch st or safe-paste to escape escape sequences in pasted text

antigen theme gallois

antigen apply

alias ls='ls --color=auto -B'

setopt extendedglob

function uva() {
    g++ -g -lm -lcrypt -O2 -pipe -DONLINE_JUDGE $1 -o $(echo $1 | rev | cut -d. -f2- | rev)
}
function uva-11() {
    g++ -g -std=c++11 -lm -lcrypt -O2 -pipe -DONLINE_JUDGE $1 -o $(echo $1 | rev | cut -d. -f2- | rev)
}

function anacondon() {
    PATH="$HOME/.anaconda3/bin:${PATH}";
}

function conda() {
    if ! [[ "$PATH" =~ ".anaconda3" ]]; then
       anacondon;
    fi

    if [[ "$1" = "activate" ]]; then
        source "$HOME/.anaconda3/envs/$2/bin/activate" "$2"
    elif [[ "$1" = "deactivate" ]]; then
        shift
        . deactivate
        anacondon
    else
        "$HOME/.anaconda3/bin/conda" $@
    fi
}

function clone() {
    git clone git@github.com:$1;
}

alias grep='grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn'

alias rs="redshift -l 38:-85"
alias syus="systemctl --user"
alias na='sudo netctl-auto'

alias start='sudo systemctl start'
alias restart='sudo systemctl restart'
alias stop='sudo systemctl stop'

alias em='emacsclient -t'

function sudo() {
   if [[ "$1" = "em" ]]; then
       em "/sudo::${@: (($#-2)),-1}"
   else
       /usr/bin/sudo $@
   fi
}

alias wem='emacsclient -nc'

function line() {
    head -n $1 $2 | tail -n 1;
}

# fix colors
TERM=xterm-256color

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit