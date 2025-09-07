{ pkgs, ... }:
{
  home.packages = with pkgs; [
    minizinc
  ];
}
