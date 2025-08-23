{ pkgs, emacs-larstvei, ... }:
{
  imports = [
    ../../system
    ../../system/darwin
  ];

  system.primaryUser = "larstvei";

  networking.hostName = "larstvei-macbookpro";

  users.users = {
    larstvei = {
      home = "/Users/larstvei";
      shell = pkgs.fish;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit emacs-larstvei; };
    users.larstvei.imports = [ ../../home ];
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
