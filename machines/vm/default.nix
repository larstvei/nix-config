{
  imports = [
    ../../modules/base
    ../../modules/nixos
  ];

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
