let
  theme = import ../theme;
in
{
  imports = [
    ./bindings
    ./hypridle
    # ./hyprlock
  ];

  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {

      exec-once = [ "swaylock || hyprctl dispatch exit" ];

      misc.disable_hyprland_logo = true;

      general = {
        border_size = 2;
        layout = "master";
      };

      # No borders or gaps when there is only one window
      workspace = "w[t1], gapsin:0, gapsout:0, border:0, rounding:0";

      decoration = {
        rounding = 16;
        inactive_opacity = 0.75;
        blur.enabled = false;
        shadow.enabled = false;
      };

      monitor = [ ",preferred,auto,1" ];

      gestures.gesture = "3, horizontal, workspace";

      animations = {
        enabled = true;
        animation = [
          "global, 1, 1.5, default"
          "windows, 1, 1.5, default, slide"
          "workspaces, 0, 0, default"
        ];
      };

      cursor = {
        enable_hyprcursor = false;
        inactive_timeout = 2;
      };

      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
      ];
    };
  };

  services.darkman = {
    lightModeScripts.hyprland-light = ''
      hyprctl keyword misc:background_color 0x${theme.bg.light}
      hyprctl keyword general:col.active_border 0xFF${theme.primary.light}
      hyprctl keyword general:col.inactive_border 0xFF${theme.secondary.light}
    '';
    darkModeScripts.hyprland-dark = ''
      hyprctl keyword misc:background_color 0x${theme.bg.dark}
      hyprctl keyword general:col.active_border 0xFF${theme.primary.dark}
      hyprctl keyword general:col.inactive_border 0xFF${theme.secondary.dark}
    '';
  };
}
