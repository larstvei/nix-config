{ config, pkgs, lib, ... }:
{
  networking.hostName = "larstvei-nixos";

  time.timeZone = "Europe/Oslo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8" "nb_NO.UTF-8" ];
  };

  users.users.larstvei = {
    isNormalUser = true;
    home = "/home/larstvei";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  services = {
    # Enable NetworkManager
    networkmanager.enable = true;
  };

  # System state version
  system.stateVersion = lib.mkDefault "24.11";
}
