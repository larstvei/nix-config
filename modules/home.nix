{
  lib,
  pkgs,
  emacs-larstvei,
  ...
}:
let
  concatAttrVals = attrSet: lib.concatMap (x: x) (lib.attrValues attrSet);
  tools = import ./tools.nix {
    inherit pkgs;
    inherit emacs-larstvei;
  };
  langauges = import ./languages.nix { inherit pkgs; };
in
{
  home.packages = concatAttrVals langauges ++ concatAttrVals tools;

  home.file.".config/enchant/hunspell/".source = "${pkgs.hunspellDicts.nb_NO}/share/hunspell/";

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
      ignores = [
        ".envrc"
        ".DS_Store"
        ".direnv"
      ];
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
  home.stateVersion = "24.11";
}
