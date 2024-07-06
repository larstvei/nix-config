{ pkgs, lib, ... }: {

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      system = aarch64-darwin # M1 gang
      extra-platforms = aarch64-darwin x86_64-darwin # But we use rosetta too
      experimental-features = nix-command flakes
      build-users-group = nixbld
      trusted-users = root larstvei
    '';
  };

  fonts.packages = with pkgs; [
    fira
    fira-code
    iosevka
    roboto
    roboto-mono
    source-sans
    source-code-pro
    source-serif
  ];

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
      # autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = [ "homebrew/cask" "homebrew/cask-versions" ];
    casks = [
      "amethyst"
      "arc"
      "chatgpt"
      "docker"
      "dropbox"
      # "expressvpn"
      # "firefox-developer-edition"
      "google-chrome"
      "iina"
      "karabiner-elements"
      # "mactex"
      "obs"
      "ollama"
      "raycast"
      "remarkable"
      "signal"
      "supercollider"
      "zoom"
    ];
  };
}
