{ pkgs, lib, config, home-manager, nix-darwin, inputs, ... }: {


  home.packages = with pkgs; [
    ((emacsPackagesFor emacsGit).emacsWithPackages
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
        nb
      ]))
    (python3.withPackages
      (python-packages: with python-packages; [
        graphviz
        hypothesis
        matplotlib
        numpy
        pandas
        pygments
        python-lsp-server
        scipy
        scikit-learn
        z3
      ]))
    (haskell.packages.ghc96.ghcWithPackages
      (ps: with ps; [
        QuickCheck
      ]))
    bat
    cbqn
    cloc
    clojure
    fd
    ffmpeg
    fzf
    go
    gopls
    graphviz
    htop
    inkscape
    jdk
    jq
    leiningen
    maude-mac
    nixpkgs-fmt
    pandoc
    parallel
    pdf2svg
    poppler_utils
    ripgrep
    rnix-lsp
    # rust-analyzer
    rustup
    shortcat
    stack
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
        set PATH "$PATH:/usr/local/texlive/2022/bin/universal-darwin/"
        export DIRENV_LOG_FORMAT=
        if test "$TERM" != "dumb"
            track_directories
        end
        direnv reload 2> /dev/null
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

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    mu.enable = true;
    msmtp.enable = true;
    mbsync.enable = true;

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
