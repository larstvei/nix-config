{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cbqn
  ];
}
