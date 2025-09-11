{
  pkgs,
  nanostatus,
  emacs-larstvei,
  zen-browser,
  ...
}:
{
  imports = [
    ./keyboard
    ./hardware
    ../../modules/base
    ../../modules/nixos
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit nanostatus emacs-larstvei zen-browser; };
    users.larstvei.imports = [
      ../../modules/home
      ../../modules/desktop
    ];
  };

  networking.hostName = "larstvei-think";

  users.users.larstvei = {
    isNormalUser = true;
    description = "Lars Tveito";
    home = "/home/larstvei";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  console.keyMap = "us";

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "hyprland";
      user = "larstvei";
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
