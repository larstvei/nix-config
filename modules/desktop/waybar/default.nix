{ config, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
  highlight = x: ''<span foreground="${colors.base0C}">${x}</span>'';
  warning = x: ''<span foreground="${colors.base08}">${x}</span>'';
  faded = x: ''<span foreground="${colors.base03}">${x}</span>'';
in
{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      spacing = 8;

      modules-left = [
        "niri/window"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "idle_inhibitor"
        "cpu"
        "memory"
        "pulseaudio"
        "network"
        "bluetooth"
        "battery"
      ];

      "niri/window" = {
        format = "{}";
        max-length = 72;
        rewrite = {
          "(.*) - Gnu Emacs at thinkpad" = "${highlight ""} $1";
          "(.*) — Zen Browser" = "${highlight "󰖟"} $1";
        };
      };

      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%A %d %B %Y, %H:%M:%S}";
        interval = 1;
        tooltip-format = "{:%A %d %B %Y, %H:%M:%S}";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = highlight "󰛊";
          deactivated = faded "󰾫";
        };
        tooltip-format-activated = "Idle inhibitor: on";
        tooltip-format-deactivated = "Idle inhibitor: off";
      };

      cpu = {
        format = "";
        interval = 5;
        tooltip-format = "{avg_frequency} GHz\n{usage}% used";
        on-click = "ghostty -e htop";
      };

      memory = {
        format = "";
        interval = 10;
        tooltip-format = "{used:0.1f} GiB used\n{avail:0.1f} GiB available\n{swapUsed:0.1f} GiB swap";
      };

      pulseaudio = {
        format = "{icon}";
        format-muted = faded "󰖁";
        format-icons = {
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          headphone = "󰋋";
        };
        on-click = "pwvucontrol";
        tooltip-format = "{desc}\n{volume}%";
      };

      network = {
        format-wifi = " ";
        format-disconnected = faded "󰤯 ";
        format-disabled = faded "󰖪 ";
        interval = 5;
        tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}\n↑ {bandwidthUpBits}  ↓ {bandwidthDownBits}";
        on-click = "nmgui";
      };

      bluetooth = {
        format = "󰂯";
        format-off = faded "󰂲";
        format-connected = highlight "󰂱";
        tooltip-format = "Status: {status}";
        tooltip-format-connected = "{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}";
        tooltip-format-enumerate-connected-battery = "{device_alias}  {device_battery_percentage}%";
        on-click = "overskride";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-charging = "${highlight "󰂄"} {capacity}%";
        format-plugged = "󰚥 {capacity}%";
        format-full = "${highlight "󰁹"}";
        format-icons = [
          (warning "󰁼")
          "󰁾"
          "󰂁"
          "󰁹"
        ];
        states = {
          warning = 20;
          critical = 10;
        };
        tooltip-format = "{capacity}%\n{timeTo}\n{power:.1f} W";
      };
    };

    style = ''
      * { font-size: 11pt; }
      window#waybar > box { padding: 0 1rem; }
      tooltip { border-width: 3px; }
    '';
  };
}
