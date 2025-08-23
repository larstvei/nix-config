{ pkgs, emacs-larstvei, ... }:
let
  v = import ./variables.nix;
in
{
  imports = [
    ../../system
    ../../system/darwin
  ];

  system.primaryUser = v.username;

  networking.hostName = v.hostName;

  users.users.${v.username} = {
    home = v.userHome;
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit emacs-larstvei; };
    users.${v.username}.imports = [ ../../home ];
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
