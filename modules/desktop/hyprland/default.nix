{ pkgs, nanostatus, ... }:
{
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {

      misc.disable_hyprland_logo = true;

      general = {
        border_size = 2;
        layout = "master";
      };

      # No borders or gaps when there is only one window
      workspace = "w[t1], gapsin:0, gapsout:0, border:0";

      decoration = {
        rounding = 15;
        inactive_opacity = 0.75;
        blur.enabled = false;
        shadow.enabled = false;
        border_part_of_window = true;
      };

      # The animations is taken from Omarchy, see:
      # https://github.com/basecamp/omarchy/blob/master/default/hypr/looknfeel.conf
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 0, 0, ease"
        ];
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
