{ self, ... }:
{
  imports = [
    ./keyboard
    ./hardware
    self.nixosModules.base
    self.nixosModules.nixos
    self.nixosModules.graphical
  ];

  home-manager.users.larstvei.imports = [
    self.homeModules.full
    self.homeModules.desktop
  ];

  services.gnome.gnome-keyring.enable = true;

  systemd.services.disable-thinkpad-leds = {
    description = "Disable ThinkPad lid logo LED and power button led";
    wantedBy = [
      "basic.target"
      "suspend.target"
    ];
    after = [
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend-then-hibernate.target"
      "suspend.target"
      "sysinit.target"
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "/bin/sh -c 'echo 0 > /sys/class/leds/tpacpi::power/brightness'"
        "/bin/sh -c 'echo 0 > /sys/class/leds/tpacpi::lid_logo_dot/brightness'"
      ];
    };
  };

  networking.hostName = "larstvei-think";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
