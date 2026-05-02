{
  inputs,
  ...
}:
let
  theme = import ../theme;
  mod = "Super+ISO_Level3_Shift";
in
{
  imports = [ inputs.niri.homeModules.niri ];

  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            variant = "mac";
            options = "lv3:alt_switch,apple:alupckeys";
          };
          repeat-delay = 300;
          repeat-rate = 50;
        };
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      cursor = {
        theme = "Adwaita";
        size = 24;
      };

      outputs."eDP-1".scale = 1.0;
      outputs."DP-3".scale = 1.0;

      prefer-no-csd = true;

      window-rules = [
        {
          geometry-corner-radius =
            let
              r = 12.0;
            in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
          clip-to-geometry = true;
        }
      ];

      layout = {
        preset-column-widths =
          let
            phi = 1.618033988749895;
          in
          [
            { proportion = 1.0 / 1.0; } # Maximize
            { proportion = 1.0 / phi; } # The golden ratio
            { proportion = 1.0 / 2.0; } # Half
            { proportion = 1.0 - (1.0 / phi); } # The remainder of the golden ratio
          ];
        background-color = "#${theme.bg.dark}";
        border = {
          enable = true;
          width = 3;
          active.color = "#${theme.primary.dark}";
          inactive.color = "#${theme.secondary.dark}";
        };
        focus-ring.enable = false;
      };

      spawn-at-startup = [ { command = [ "swaylock" ]; } ];

      binds = {
        # Window management
        "${mod}+Q".action.close-window = [ ];
        "${mod}+F".action.fullscreen-window = [ ];
        "${mod}+O".action.toggle-overview = [ ];
        "${mod}+C".action.center-column = [ ];
        "${mod}+Shift+Slash".action.show-hotkey-overlay = [ ];

        # Focus (HJKL)
        "${mod}+H".action.focus-column-left = [ ];
        "${mod}+J".action.focus-window-or-workspace-down = [ ];
        "${mod}+K".action.focus-window-or-workspace-up = [ ];
        "${mod}+L".action.focus-column-right = [ ];

        # Move windows
        "${mod}+Shift+H".action.move-column-left = [ ];
        "${mod}+Shift+J".action.move-window-down-or-to-workspace-down = [ ];
        "${mod}+Shift+K".action.move-window-up-or-to-workspace-up = [ ];
        "${mod}+Shift+L".action.move-column-right = [ ];

        # Monitor focus/move
        "${mod}+Comma".action.focus-monitor-left = [ ];
        "${mod}+Period".action.focus-monitor-right = [ ];
        "${mod}+Shift+Comma".action.move-column-to-monitor-left = [ ];
        "${mod}+Shift+Period".action.move-column-to-monitor-right = [ ];

        # Consume into columns
        "${mod}+BracketLeft".action.consume-or-expel-window-left = [ ];
        "${mod}+BracketRight".action.consume-or-expel-window-right = [ ];

        # Resize
        "${mod}+Minus".action.set-column-width = "-1%";
        "${mod}+Equal".action.set-column-width = "+1%";
        "${mod}+Return".action.switch-preset-column-width = [ ];
        "${mod}+Shift+Return".action.switch-preset-column-width-back = [ ];

        # Lock
        "${mod}+Delete".action.spawn = [ "swaylock" ];

        # App launchers
        "${mod}+T".action.spawn = [ "ghostty" ];
        "${mod}+E".action.spawn = [ "emacs" ];
        "${mod}+B".action.spawn = [ "zen-beta" ];
        "${mod}+D".action.spawn-sh = [ "darkman toggle" ];
        "${mod}+Space".action.spawn = [ "nanostatus-toggle" ];
        "${mod}+Shift+M".action.spawn-sh = [ "wl-mirror $(niri msg --json focused-output | jq -r .name)" ];

        # Screenshots (niri built-in)
        "${mod}+S".action.screenshot = [ ];
        "${mod}+Shift+S".action.screenshot-screen = [ ];
        "Print".action.screenshot-screen = [ ];
        "Shift+Print".action.screenshot-window = [ ];

        # Media & brightness
        "XF86AudioRaiseVolume".action.spawn-sh = [ "swayosd-client --output-volume raise" ];
        "XF86AudioLowerVolume".action.spawn-sh = [ "swayosd-client --output-volume lower" ];
        "XF86AudioMute".action.spawn-sh = [ "swayosd-client --output-volume mute-toggle" ];
        "XF86AudioMicMute".action.spawn-sh = [ "swayosd-client --input-volume mute-toggle" ];
        "XF86MonBrightnessUp".action.spawn-sh = [ "swayosd-client --brightness raise" ];
        "XF86MonBrightnessDown".action.spawn-sh = [ "swayosd-client --brightness lower" ];
        "Shift+XF86MonBrightnessUp".action.spawn-sh = [ "swayosd-client --brightness 100" ];
        "Shift+XF86MonBrightnessDown".action.spawn-sh = [ "swayosd-client --brightness 1" ];

        # Workspaces
        "${mod}+1".action.focus-column = 1;
        "${mod}+2".action.focus-column = 2;
        "${mod}+3".action.focus-column = 3;
        "${mod}+4".action.focus-column = 4;
        "${mod}+5".action.focus-column = 5;
        "${mod}+6".action.focus-column = 6;
        "${mod}+7".action.focus-column = 7;
        "${mod}+8".action.focus-column = 8;
        "${mod}+9".action.focus-column = 9;

        "${mod}+Shift+1".action.move-column-to-index = 1;
        "${mod}+Shift+2".action.move-column-to-index = 2;
        "${mod}+Shift+3".action.move-column-to-index = 3;
        "${mod}+Shift+4".action.move-column-to-index = 4;
        "${mod}+Shift+5".action.move-column-to-index = 5;
        "${mod}+Shift+6".action.move-column-to-index = 6;
        "${mod}+Shift+7".action.move-column-to-index = 7;
        "${mod}+Shift+8".action.move-column-to-index = 8;
        "${mod}+Shift+9".action.move-column-to-index = 9;
      };
    };
  };

}
