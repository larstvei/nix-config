{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof swaylock || swaylock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150; # 2.5 min
          on-timeout = "brightnessctl --save && brightnessctl set 1";
          on-resume = "brightnessctl --restore";
        }
        {
          timeout = 900; # 15 min
          on-timeout = "systemctl suspend-then-hibernate";
        }
      ];
    };
  };
}
