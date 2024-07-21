{ pkgs, emacs-larstvei, ... }: {

  home.packages = with pkgs; [
    emacs-larstvei.defaultPackage.${pkgs.system}
    (aspellWithDicts
      (dpkgs: with dpkgs; [
        en
        en-computers
        nb
      ]))
    (python3.withPackages
      (python-packages: with python-packages; [
        graphviz
        html2text
        hypothesis
        matplotlib
        numpy
        openpyxl
        pandas
        pygments
        python-lsp-server
        scikit-learn
        scipy
        xlsxwriter
        yattag
        z3
      ]))
    (haskell.packages.ghc96.ghcWithPackages
      (ps: with ps; [
        QuickCheck
      ]))
    bat
    babashka
    # cargo
    cbqn
    clj-kondo
    cloc
    clojure
    devenv
    fd
    ffmpeg
    fzf
    go
    gopls
    graphviz
    htop
    imagemagick
    inkscape
    jdk
    jet
    jq
    leiningen
    minizinc
    nil
    neil
    nixfmt
    pandoc
    parallel
    pdf2svg
    poppler_utils
    ripgrep
    # rust-analyzer
    rustup
    stack
    texlive.combined.scheme-full
    tree
    wget
  ];

  # Somehow related to: https://github.com/NixOS/nixpkgs/issues/1000
  home.file.".aspell.conf".text = "data-dir ${pkgs.aspell}/lib/aspell";

  home.file.karabiner = {
    target = ".config/karabiner/assets/complex_modifications/df_escape.json";
    text = builtins.toJSON {
      title = "Simultaneously press f + d to escape";
      rules = [{
        description = "Simultaneously press f + d to escape";
        manipulators = [
          {
            type = "basic";
            from = {
              simultaneous = [
                { key_code = "f"; }
                { key_code = "d"; }
              ];
            };
            to = [
              { key_code = "escape"; }
            ];
          }
        ];
      }];
    };
  };

  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    fish = {
      enable = true;

      functions = {
        track_directories = {
          description = "For directory tracking in emacs vterm";
          onEvent = "fish_postexec";
          body = "printf \'\\e]51;A\'(pwd)\'\\e\\\\\'";
        };
      };

      shellInit = ''
        if test "$TERM" != "dumb"
            track_directories
        end
        set -gx DIRENV_LOG_FORMAT ""
        direnv hook fish | source
      '';
    };

    starship = {
      enable = true;
      settings = {
        custom = {
          direnv = {
            format = "[\\[direnv\\]]($style) ";
            when = "env | grep -E '^DIRENV_FILE='";
          };
        };
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
      };
    };

    git = {
      enable = true;
      userName = "larstvei";
      userEmail = "larstvei@ifi.uio.no";
      ignores = [ ".envrc" ".DS_Store" ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Sets JAVA_HOME environment variable
    java.enable = true;

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
