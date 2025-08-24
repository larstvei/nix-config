{ pkgs, ... }:
{
  home.packages = [
    pkgs.wtype
    pkgs.rofi-wayland
    pkgs.brightnessctl
  ];

  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      monitor = [ ",preferred,auto,1.2" ];

      xwayland.force_zero_scaling = true;

      gestures.workspace_swipe = true;

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
        "$mod, E, exec, emacsclient -c"
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
