{ pkgs, nanostatus, ... }:
{
  wayland.windowManager.hyprland.settings = {
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
      # Master layout
      "$mod, F, fullscreen"
      "$mod, Return, layoutmsg, swapwithmaster master"
      "$mod, minus, layoutmsg, mfact -0.01"
      "$mod, equal, layoutmsg, mfact +0.01"
      "$mod, Tab, layoutmsg, cyclenext"
      "$shiftMod, Tab, layoutmsg, cycleprev"
      "$mod, comma, layoutmsg, addmaster"
      "$mod, period, layoutmsg, removemaster"

      # App launchers / session
      "$mod, T, exec, kitty"
      "$mod, E, exec, emacs"
      "$mod, B, exec, zen"
      "$mod, Q, killactive"

      "$mod, S, exec, grimblast copysave area /tmp/screenshot-$(date +%F--%T).png"
      "$shiftMod, S, exec, grimblast copysave screen /tmp/screenshot-$(date +%F--%T).png"

      # Window focus & movement
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"
      "$shiftMod, H, movewindow, l"
      "$shiftMod, J, movewindow, d"
      "$shiftMod, K, movewindow, u"
      "$shiftMod, L, movewindow, r"

      "$mod, =, resizeactive, +10"
      "$mod, -, resizeactive, -10"

      "$mod, D, exec, darkman toggle"
      "$mod, space, exec, ${nanostatus.packages.${pkgs.system}.default}/bin/nanostatus-toggle"
      "$mod, backspace, exec, hyprlock"

      # Text input (macOS-like way of producing Norwegian characters)
      "$mod, A, exec, wtype 'å'"
      "$mod, O, exec, wtype 'ø'"
      "$mod, apostrophe, exec, wtype 'æ'"
      "$shiftMod, A, exec, wtype 'Å'"
      "$shiftMod, O, exec, wtype 'Ø'"
      "$shiftMod, apostrophe, exec, wtype 'Æ'"

      # Media & brightness
      ", XF86AudioRaiseVolume, exec, pamixer -i 5 "
      ", XF86AudioLowerVolume, exec, pamixer -d 5 "
      ", XF86AudioMute, exec, pamixer -t"
      ", XF86AudioMicMute, exec, pamixer --default-source -t"
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      "SHIFT, XF86MonBrightnessUp, exec, brightnessctl set 100%"
      "SHIFT, XF86MonBrightnessDown, exec, brightnessctl set 1"
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
}
