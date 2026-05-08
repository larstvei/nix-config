{ pkgs, ... }:
{
  home.packages = [
    pkgs.home-manager
  ];

  home.stateVersion = "24.11";
}
