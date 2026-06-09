{ self, user, ... }:
{
  imports = [
    ./keyboard
    ./hardware
    self.nixosModules.base
    self.nixosModules.nixos
    self.nixosModules.graphical
  ];

  home-manager.users."${user.name}".imports = [
    self.homeModules.full
    self.homeModules.desktop
    self.homeModules.backup
  ];

  services.gnome.gnome-keyring.enable = true;

  # Save power
  services.tlp.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
