{
  imports = [
    ./keyboard
    ./hardware
    ../../modules/base
    ../../modules/nixos
  ];

  home-manager.users.larstvei.imports = [
    ../../modules/home/full
    ../../modules/desktop
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "hyprland";
      user = "larstvei";
    };
  };

  networking.hostName = "larstvei-think";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
