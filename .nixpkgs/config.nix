rec {
  allowUnfree = true;

  chromium = {
    enablePepperFlash = true;
  };

  pkgs = import <nixpkgs> {};
  local-pkgs = import <local-pkgs> {};
  localNodePackages = import ./node (with local-pkgs; {
    self = nodePackages // localNodePackages;
    inherit fetchurl fetchgit lib;
  });

  nodejs-common = with local-pkgs; [ nodejs nodePackages.gulp localNodePackages.tern ];
  python-common = python: [ pkgs.gcc ] ++ (with python; [ pip virtualenv ipython pytest jedi flake8 ]);

  mkEnv = args: pkgs.myEnvFun ({
    shell = args.shell or "${pkgs.zsh.outPath}/bin/zsh";
    buildInputs = pkgs.stdenv.defaultNativeBuildInputs ++ (args.buildInputs or []);
    extraCmds = ''
      unset http_proxy
    '' + (args.extraCmds or "");
  } // args);

  packageOverrides = pkgs: rec {

    st = pkgs.st.override {
      conf = builtins.readFile "/home/emallson/dotfiles/config.h";
    };

    wineWorking = pkgs.stdenv.lib.overrideDerivation pkgs.wineUnstable (oldAttrs: rec {
      version = "1.7.17";
      name = "wine-${version}";
      src = pkgs.fetchurl {
        url = "mirror://sourceforge/wine/${name}.tar.bz2";
        sha256 = "bb6fbd7fd70f9aafba557995d9ce537ded56e750e0a89a062e3318d584a8abef";
      };
    });

    warc-scikit-image = pkgs.stdenv.lib.overrideDerivation local-pkgs.python27Packages.scikit-image (oldAttrs: {
      name = "scikit-image-git-emallson";
      src = pkgs.fetchgit {
        url = https://github.com/emallson/scikit-image.git;
        sha256 = "d0c610e67f77961741d06736e16d24855788d3f9220ef8111f57da5f8bc7dae2";
      };
    });

    cv-python-env = mkEnv {
      name = "cv-python";
      buildInputs = with pkgs; python-common python27Packages ++ [
                      git
                      python27Full
                      python27Packages.wxPython
                      wxGTK30
                      python27Packages.pillow
                      python27Packages.numpy
                      python27Packages.scipy
                      python27Packages.h5py
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
        wineWorking
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

    cloudsplosion-env = mkEnv {
      name = "cloudsplosion";
      buildInputs = nodejs-common ++ (with pkgs; [
        docker
      ]);
    };

    singleview-env = mkEnv {
      name = "singleview";
      buildInputs = nodejs-common ++ ((python-common pkgs.python27Packages) ++ (with pkgs; [
        opencv
      ]));
    };

    learn2play-env = mkEnv {
      name = "l2p";
      buildInputs = (python-common pkgs.python27Packages) ++ (with pkgs; [
        pltScheme
        x11
      ]);
    };
  };
}
