{ pkgs, ... }:
{
  home.packages = with pkgs; [
    maude
  ];
}
