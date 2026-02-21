{ self, ... }:
{
  imports = [
    ./hardware
    self.nixosModules.base
    self.nixosModules.nixos
  ];

  home-manager.users.larstvei.imports = [
    self.homeModules.minimal
  ];

  networking.hostName = "larstvei-vm";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11";
}
