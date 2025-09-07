{
  programs = {
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

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
      settings = {
        custom = {
          direnv = {
            format = "[\\[direnv\\]]($style) ";
            when = "test -n \"$DIRENV_FILE\"";
          };
        };
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
      };
    };
  };
}
