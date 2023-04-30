{ config, pkgs, lib, ... }: {

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      system = aarch64-darwin # M1 gang
      extra-platforms = aarch64-darwin x86_64-darwin # But we use rosetta too
      experimental-features = nix-command flakes
      build-users-group = nixbld
    '';
  };

  fonts = {
    fontDir.enable = false;
    fonts = with pkgs; [
      fira
      fira-code
      roboto
      roboto-mono
    ];
  };

  users.users."larstvei".home = "/Users/larstvei";

  programs.fish.enable = true;
  system.activationScripts.postActivation.text = ''
    # Set the default shell as fish for the user. MacOS doesn't do this like nixOS does
    sudo chsh -s ${lib.getBin pkgs.fish}/bin/fish larstvei
  '';

  networking.hostName = "macbookpro";

  system = {
    stateVersion = 4;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    defaults = {
      screencapture = { location = "/tmp"; };
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
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = [ "homebrew/cask" ];
    casks = [
      "amethyst"
      "dropbox"
      "expressvpn"
      "google-chrome"
      "iina"
      "karabiner-elements"
      "mactex"
      "orion"
      "raycast"
      "remarkable"
      "signal"
      "zoom"
    ];
  };
}
