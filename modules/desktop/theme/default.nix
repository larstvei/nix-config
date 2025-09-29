let
  bg = {
    light = "FAFAFA";
    dark = "2E3440";
  };
  fg = {
    light = "37474F";
    dark = "ECEFF4";
  };
  primary = {
    light = "673AB7";
    dark = "81A1C1";
  };
  secondary = {
    light = "90A4AE";
    dark = "677691";
  };
in
{
  services.darkman = {
    enable = true;
    settings.portal = true;
    lightModeScripts.hyprland-light = ''
      hyprctl keyword misc:background_color 0x${bg.light}
      hyprctl keyword general:col.active_border 0xFF${primary.light}
      hyprctl keyword general:col.inactive_border 0xFF${secondary.light}
    '';
    darkModeScripts.hyprland-dark = ''
      hyprctl keyword misc:background_color 0x${bg.dark}
      hyprctl keyword general:col.active_border 0xFF${primary.dark}
      hyprctl keyword general:col.inactive_border 0xFF${secondary.dark}
    '';
  };
}
