{ pkgs, ... }:
{
  home.packages = with pkgs; [
    exercism
  ];
}
