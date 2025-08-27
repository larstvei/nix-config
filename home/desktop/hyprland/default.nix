{ pkgs, ... }:
{
  home.packages = [
    pkgs.adwaita-icon-theme
    pkgs.brightnessctl
    pkgs.pamixer
    pkgs.rofi-wayland
    pkgs.wtype
  ];

  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      monitor = [ ",preferred,auto,1" ];

      gestures.workspace_swipe = true;

      cursor = {
        enable_hyprcursor = false;
      };

      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
      ];

      input = {
        kb_options = "altwin:swap_alt_win";

        repeat_delay = 300;
        repeat_rate = 50;

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.4;
          tap-to-click = true;
        };
      };

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      bind = [
        # Open and close applications
        "$mod, RETURN, exec, kitty"
        "$mod, E, exec, emacs"
        "$mod, B, exec, zen"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, Q, killactive"

        # Window management
        "$mod, F, fullscreen"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$shiftMod, H, movewindow, l"
        "$shiftMod, J, movewindow, d"
        "$shiftMod, K, movewindow, u"
        "$shiftMod, L, movewindow, r"

        # Norwegian characters
        "$mod, A, exec, wtype 'å'"
        "$mod, O, exec, wtype 'ø'"
        "$mod, semicolon, exec, wtype 'æ'"
        "$shiftMod, A, exec, wtype 'Å'"
        "$shiftMod, O, exec, wtype 'Ø'"
        "$shiftMod, semicolon, exec, wtype 'Æ'"

        ", XF86AudioRaiseVolume, exec, pamixer -i 5 "
        ", XF86AudioLowerVolume, exec, pamixer -d 5 "
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -t"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ]
      ++ builtins.concatLists (
        builtins.genList (
          i:
          let
            code = "1${toString i}";
            ws = toString (i + 1);
          in
          [
            "$mod, code:${code}, workspace, ${ws}"
            "$shiftMod, code:${code}, movetoworkspace, ${ws}"
          ]
        ) 9
      );
    };
  };
}
