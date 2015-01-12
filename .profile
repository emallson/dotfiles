# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacsclient -c'
else
  export EDITOR='emacs'
fi

export CHROME_BIN=chromium;
PATH="/opt/MATLAB/R2014a/bin:$HOME/.cabal/bin:$HOME/.root/bin:$HOME/bin:$PATH"

export NVM_DIR="/home/emallson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# OPAM configuration
. /home/emallson/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

systemctl --user import-environment PATH
