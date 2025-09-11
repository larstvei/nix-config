{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gambit
  ];
}
