{
  pkgs,
  lib,
  user,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "niri-session";
        user = user.name;
      };
      default_session = initial_session;
    };
  };

  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.darkman
    ];

    config.niri = {
      default = lib.mkForce [ "gtk" ];
      "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
    };
  };
}
