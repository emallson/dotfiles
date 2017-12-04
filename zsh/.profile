# Preferred editor for local and remote sessions
if [ -n $SSH_CONNECTION ]; then
  export EDITOR='emacsclient -c'
else
  export EDITOR='emacs'
fi

export CHROME_BIN=chromium;
export BROWSER=$CHROME_BIN;
export PATH="$HOME/.cargo/bin:$HOME/.cask/bin:$HOME/.cabal/bin:$HOME/.local/bin:$PATH";
export CARGO_HOME="$HOME/.cargo/"

# OPAM configuration
. /home/emallson/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export NVM_DIR="/home/emallson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

eval `dircolors ~/.dircolors`;

export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
export BOOT_JVM_OPTIONS='-client -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xverify:none'
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/gurobi752/linux64/lib

which systemctl &> /dev/null && systemctl --user import-environment PATH

export PATH="$HOME/.gem/ruby/2.3.0/bin/:$HOME/.cargo/bin:$PATH"
