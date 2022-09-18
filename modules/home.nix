{ pkgs, lib, config, home-manager, nix-darwin, inputs, ... }: {

  # Can probably be removed when this is resolved:
  # https://github.com/nix-community/home-manager/issues/1341
  home.activation = {
    copyApplications = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
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
      (epkgs: [
        epkgs.vterm
        epkgs.pdf-tools
      ]))
    sqlite
    htop
    (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
    fd
    fzf
    ripgrep
    nixpkgs-fmt
    tree
    wget
  ];

  home.file.".aspell.conf".text = "data-dir ${pkgs.aspell}/lib/aspell";

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    functions = {
      track_directories = {
        description = "For directory tracking in emacs vterm";
        onEvent = "fish_postexec";
        body = "printf \'\\e]51;A\'(pwd)\'\\e\\\\\'";
      };
    };

    shellInit = ''
    track_directories
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "larstvei";
    userEmail = "larstvei@ifi.uio.no";
    ignores = [ ".dir-locals.el" ".envrc" ".DS_Store" ];
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
