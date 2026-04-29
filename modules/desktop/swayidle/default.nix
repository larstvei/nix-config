{ pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
    timeouts = [
      {
        timeout = 150; # 2.5 min
        command = "${pkgs.brightnessctl}/bin/brightnessctl --save && ${pkgs.brightnessctl}/bin/brightnessctl set 1";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl --restore";
      }
      {
        timeout = 900; # 15 min
        command = "systemctl suspend-then-hibernate";
      }
    ];
  };
}
