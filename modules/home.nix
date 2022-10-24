{ pkgs, lib, config, home-manager, nix-darwin, inputs, ... }: {

  # Can probably be removed when this is resolved:
  # https://github.com/nix-community/home-manager/issues/1341
  home.activation = {
    copyApplications =
      let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        baseDir="$HOME/Applications/Home Manager Apps"
        if [ -d "$baseDir" ]; then
          rm -rf "$baseDir"
        fi
        mkdir -p "$baseDir"
        for appFile in ${apps}/Applications/*; do
          target="$baseDir/$(basename "$appFile")"
          $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
          $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
        done
      '';
  };


  home.packages = with pkgs; [
    ((emacsPackagesFor emacs-mac).emacsWithPackages
      (epkgs: with epkgs; [
        vterm
        pdf-tools
        pkgs.mu
      ]))
    (aspellWithDicts
      (dpkgs: with dpkgs; [
        en
        en-computers
        en-science
      ]))
    (python3.withPackages
      (python-packages: with python-packages; [
        hypothesis
        graphviz
        z3
        pygments
      ]))
    bat
    cbqn
    cloc
    clojure
    fd
    ffmpeg
    fzf
    go
    graphviz
    htop
    inkscape
    leiningen
    nixpkgs-fmt
    jdk
    pandoc
    parallel
    poppler_utils
    ripgrep
    rnix-lsp
    rust-analyzer
    rustup
    texlive.combined.scheme-full
    tree
    wget
  ];

  # Somehow related to: https://github.com/NixOS/nixpkgs/issues/1000
  home.file.".aspell.conf".text = "data-dir ${pkgs.aspell}/lib/aspell";

  accounts.email = {
    accounts.uio = {
      address = "larstvei@ifi.uio.no";
      userName = "larstvei@ifi.uio.no";
      realName = "Lars Tveito";
      imap.host = "imap.uio.no";
      smtp.host = "smtp.uio.no";

      mbsync = {
        enable = true;
        create = "maildir";
        # Because of Office 365, see: https://kdecherf.com/blog/2017/05/01/mbsync-and-office-365/
        extraConfig.account.Timeout = 120;
        extraConfig.account.PipelineDepth = 1;
      };

      msmtp.enable = true;
      mu.enable = true;

      primary = true;
      passwordCommand = "security find-internet-password -s imap.uio.no -a larstvei -w";
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
      '';
    };

    starship = {
      enable = true;
      settings = {
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
      ignores = [ ".dir-locals.el" ".envrc" ".DS_Store" ];
    };

    mu.enable = true;
    msmtp.enable = true;
    mbsync.enable = true;

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
