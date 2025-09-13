{
  imports = [
    ../../modules/base
    ../../modules/nixos
  ];

  home-manager.users.larstvei.imports = [
    ../../modules/home/minimal
    ../../modules/desktop
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "hyprland";
      user = "larstvei";
    };
  };

  networking.hostName = "larstvei-vm";

  # VM-friendly bits
  services.qemuGuest.enable = true; # qemu-guest-agent
  services.spice-vdagentd.enable = true; # better clipboard/display if using SPICE

  # In VMs Hyprland can benefit from this
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # Use EFI boot in the image
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
