{ pkgs, ... }:
{
  fonts.packages = import ../../home/fonts { inherit pkgs; };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  nixpkgs.config.allowUnfree = true;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
