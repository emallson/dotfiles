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
    PATH="$HOME/anaconda/bin:${PATH}";
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

alias em='emacsclient -nw -c'
alias wem='emacsclient -c'

function ns() {
    if [[ -z "$1" ]]; then
        nix-shell --command zsh --pure;
    elif [[ -a "$1" ]]; then
        nix-shell --command zsh --pure "$1";
    else
        nix-shell --command zsh --pure ~/.nixpkgs/envs/$1.nix;
    fi
}

function nix_env_status() {
    if [[ -n "$name" && -z "$NIX_MYENV_NAME" ]]; then NIX_MYENV_NAME=$name; fi

    if [[ -n "$NIX_MYENV_NAME" ]]; then
        echo "%{$fg[blue]%}[$NIX_MYENV_NAME]%b";
    else
        echo "";
    fi
}

function le() {
    load-env-$1;
}

function _le() {
    reply=($(nix-env -q | grep env- | gawk 'match($0, /env-(.+)/, m) { print m[1]; }'));
}

compctl -K _le le;

PS1="$(nix_env_status)$PS1"

# fix colors
TERM=xterm-256color
