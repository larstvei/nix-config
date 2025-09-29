{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [
        {
          timeout = 150; # 2.5 min
          on-timeout = "brightnessctl --save && brightnessctl set 1";
          on-resume = "brightnessctl --restore";
        }
        {
          timeout = 300; # 5 min
          on-resume = "loginctl lock-session";
        }
        {
          timeout = 900; # 15 min
          on-timeout = "systemctl suspend-then-hibernate";
        }
      ];
    };
  };
}
