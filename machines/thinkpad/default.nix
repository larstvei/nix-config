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
    extraSpecialArgs = {
      inherit nanostatus;
      inherit emacs-larstvei;
      inherit zen-browser;
    };
    users.larstvei.imports = [
      ../../modules/home
      ../../modules/desktop
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "hyprland";
        user = "larstvei";
      };
    };
  };

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

  networking.hostName = "larstvei-think";

  console.keyMap = "us";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
