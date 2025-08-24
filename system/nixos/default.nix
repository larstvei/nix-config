{ pkgs, ... }:
{
  fonts.packages = import ../../home/fonts { inherit pkgs; };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
}
