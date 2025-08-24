{ pkgs, ... }:
{
  home.packages = [
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
        natural_scroll = true;
        scroll_factor = 0.4;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.4;
          tap-to-click = true;
        };
      };

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, E, exec, emacsclient -c"
        "$mod, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"

        "$mod, F, fullscreen"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$shiftMod, H, movewindow, l"
        "$shiftMod, J, movewindow, d"
        "$shiftMod, K, movewindow, u"
        "$shiftMod, L, movewindow, r"

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
