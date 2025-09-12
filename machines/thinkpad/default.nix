{
  imports = [
    ./keyboard
    ./hardware
    ../../modules/base
    ../../modules/nixos
  ];

  networking.hostName = "larstvei-think";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
