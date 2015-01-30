rec {
  allowUnfree = true;

  chromium = {
    enablePepperFlash = true;
  };

  pkgs = import /home/emallson/Code/nixpkgs {};
  localNodePackages = import ./node (with pkgs; {
    self = nodePackages // localNodePackages;
    inherit fetchurl fetchgit lib;
  });

  nodejs-common = with pkgs; [ nodejs nodePackages.gulp localNodePackages.tern ];
  python-common = python: [ pkgs.gcc ] ++ (with python; [ pip virtualenv ipython ]);

  mkEnv = args: pkgs.myEnvFun ({
    shell = args.shell or "${pkgs.zsh.outPath}/bin/zsh";
    buildInputs = pkgs.stdenv.defaultNativeBuildInputs ++ (args.buildInputs or []);
    extraCmds = ''
      unset http_proxy;
    '' + (args.extraCmds or "");
  } // args);

  packageOverrides = pkgs: rec {
    st = pkgs.st.override {
      conf = builtins.readFile "/home/emallson/dotfiles/config.h";
    };

    warc-scikit-image = pkgs.stdenv.lib.overrideDerivation pkgs.python27Packages.scikit-image (oldAttrs: {
      name = "scikit-image-git-emallson";
      src = pkgs.fetchgit {
        url = https://github.com/emallson/scikit-image.git;
        sha256 = "58647a7e5cd7f9b06cd0d8551aa8c2fcac294bfd6ad9592cb7f3c955da37672d";
      };
    });

    cv-python-env = mkEnv {
      name = "cv-python";
      buildInputs = with pkgs; python-common python27Packages ++ [
                      git
                      python27Full
                      python27Packages.numpy
                      python27Packages.scipy
                      python27Packages.warc
                      warc-scikit-image
                    ];
    };

    titanium-env = mkEnv {
      name = "titanium";
      buildInputs = with pkgs; nodejs-common ++ [
        git
        oraclejdk8
        androidsdk_4_4
        nodePackages.titanium
      ];
    };

    wine-env = mkEnv {
      name = "wine";
      buildInputs = with pkgs; python-common python33Packages ++ [
        wine
        python33Packages.mutagen
      ];
    };

    clojure-env = mkEnv {
      name = "clojure";
      buildInputs = with pkgs; [
        leiningen
      ];
    };

    erlang-env = mkEnv {
      name = "erlang";
      buildInputs = with pkgs; [
        erlang
      ];
    };

    node-env = mkEnv {
      name = "node";
      buildInputs = nodejs-common;
    };
  };
}
