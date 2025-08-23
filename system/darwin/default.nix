{ pkgs, ... }:
{

  fonts.packages = import ../../home/fonts { inherit pkgs; };

  nix.linux-builder.enable = true;

  users.users = {
    larstvei = {
      home = "/Users/larstvei";
      shell = pkgs.fish;
    };
  };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  system = {
    primaryUser = "larstvei";

    stateVersion = 4;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    defaults = {
      screencapture = {
        location = "/tmp";
      };
      dock = {
        autohide = true;
        showhidden = true;
        mru-spaces = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = true;
      };

      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        AppleFontSmoothing = 1;
        _HIHideMenuBar = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 1;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.swipescrolldirection" = true;
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      # autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    casks = [
      "amethyst"
      "arc"
      "chatgpt"
      "darktable"
      "dropbox"
      "google-chrome"
      "iina"
      "karabiner-elements"
      "obs"
      "ollama"
      "processing"
      "racket"
      "raycast"
      "remarkable"
      "signal"
      "skim"
      "supercollider"
      "utm"
      "zoom"
      "zen-browser"
    ];
  };
}
