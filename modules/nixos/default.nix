{ pkgs, ... }:
{

  imports = [
    ../fonts
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif 4" ];
        sansSerif = [ "Source Sans 3" ];
        monospace = [ "Source Code Pro" ];
      };
    };
  };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  nixpkgs.config.allowUnfree = true;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
