# Preferred editor for local and remote sessions
export EDITOR=nvim;
export CHROME_BIN=chromium;
export BROWSER=firefox;
export PATH="$HOME/.cargo/bin:$HOME/.cask/bin:$HOME/.cabal/bin:$HOME/.local/bin:$PATH";
export CARGO_HOME="$HOME/.cargo/"

export NVM_DIR="/home/emallson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

eval `dircolors ~/.dircolors`;

export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
export BOOT_JVM_OPTIONS='-client -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xverify:none'

which systemctl &> /dev/null && systemctl --user import-environment PATH

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

export GUIX_PROFILE="$HOME/.guix-profile"
. "$GUIX_PROFILE/etc/profile"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
