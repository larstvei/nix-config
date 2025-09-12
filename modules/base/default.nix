{ pkgs, ... }:
{
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  time.timeZone = "Europe/Oslo";

  nix = {
    package = pkgs.nix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      build-users-group = "nixbld";

      trusted-users = [
        "root"
        "larstvei"
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://larstvei.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "larstvei.cachix.org-1:mJq98qeTBnm2xNNibn2BEwN1ggi6uQg+5hWASdG1Vys="
      ];
    };
  };

  environment.systemPackages = [
    pkgs.git
    pkgs.htop
    pkgs.tree
  ];
}
