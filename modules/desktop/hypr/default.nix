{
  imports = [
    ./animations
    ./bindings
    ./hypridle
    ./hyprlock
  ];

  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {

      exec-once = [ "hyprlock || hyprctl dispatch exit" ];

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

      gestures.workspace_swipe = true;

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
}
