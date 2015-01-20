{
  allowUnfree = true;
  packageOverrides = pkgs: rec {
    st = pkgs.st.override {
      conf = builtins.readFile "/home/emallson/dotfiles/config.h";
    };
  };
}
