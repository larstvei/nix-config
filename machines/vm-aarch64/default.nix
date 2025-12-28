{
  imports = [
    ./hardware
    ../../modules/base
    ../../modules/nixos
  ];

  home-manager.users.larstvei.imports = [
    ../../modules/home/minimal
    ../../modules/desktop
  ];

  networking.hostName = "larstvei-vm";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11";
}
