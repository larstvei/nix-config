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
          "(.*) - Gnu Emacs at thinkpad" = " $1";
          "(.*) — Zen Browser" = "󰈹 $1";
        };
      };

      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%A %d %B %Y, %H:%M:%S}";
        interval = 1;
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰅶";
          deactivated = "󰾪";
        };
        tooltip-format-activated = "Idle inhibitor: on";
        tooltip-format-deactivated = "Idle inhibitor: off";
      };

      cpu = {
        format = "󰻠 {usage}%";
        interval = 5;
        tooltip-format = "{avg_frequency} GHz\n{usage}% used";
        on-click = "ghostty -e htop";
      };

      memory = {
        format = "󰍛 {percentage}%";
        interval = 10;
        tooltip-format = "{used:0.1f} GiB used\n{avail:0.1f} GiB available\n{swapUsed:0.1f} GiB swap";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-bluetooth = "󰂯 {volume}%";
        format-muted = "󰖁 muted";
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
        format-wifi = "󰤨 {essid}";
        format-disconnected = "󰤭 ";
        interval = 5;
        tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}\n↑ {bandwidthUpBits}  ↓ {bandwidthDownBits}";
        on-click = "nmgui";
      };

      bluetooth = {
        on-click = "overskride";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰚥 {capacity}%";
        format-full = "󰁹";
        format-icons = [
          "󰂎"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
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
      tooltip { border-width: 3px; }
      #battery.warning { color: @base0A; }
      #battery.critical { color: @base08; }
      #idle_inhibitor.activated { color: @base0C; }
    '';
  };
}
