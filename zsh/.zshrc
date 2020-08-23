unset GREP_OPTIONS;

source ~/.zsh.d/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle git-flow-avh
antigen bundle lein
antigen bundle emallson/gulp-zsh-completion

antigen bundle autojump
antigen bundle safe-paste       # todo: patch st or safe-paste to escape escape sequences in pasted text
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle emallson/notifyosd.zsh
antigen bundle zsh-users/zsh-autosuggestions

antigen theme gallois

antigen apply

alias ls='ls --color=auto -B'

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

setopt extended_glob

function anacondon() {
    PATH="$HOME/miniconda3/bin:${PATH}";
}

function clone() {
    git clone git@github.com:$1;
}

alias grep='grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn'

alias syus="systemctl --user"
alias na='sudo netctl-auto'

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

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fpath+=~/.zfunc
autoload -Uz compinit
compinit

bindkey '^B' push-line-or-edit

# OPAM configuration
. /home/emallson/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/emallson/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/emallson/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/emallson/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/emallson/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias fd=fdfind

eval "$(direnv hook zsh)"


function add-music() {
    if [[ $(basename "$1") =~ "(.+) - (.+)\.zip" ]]; then
       artist=$match[1];
       album=$match[2];

       mkdir -p "$HOME/Music/$artist/$album";
       unzip -d "$HOME/Music/$artist/$album" "$1";
       cd "$HOME/Music/$artist/$album";
       metaflac --add-replay-gain *.flac;
       mpc update;
       cd -1;
    fi
}
