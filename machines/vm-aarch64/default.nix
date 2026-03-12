{ self, user, ... }:
{
  imports = [
    ./hardware
    self.nixosModules.base
    self.nixosModules.nixos
  ];

  home-manager.users."${user.name}".imports = [
    self.homeModules.minimal
  ];

  networking.hostName = "${user.name}-vm";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11";
}
