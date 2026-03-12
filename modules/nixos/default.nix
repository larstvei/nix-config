{ pkgs, inputs, user, ... }:
{

  imports = [
    ../fonts
    ./printing
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs user; };
  };

  users.users.larstvei = {
    isNormalUser = true;
    description = "Lars Tveito";
    home = "/home/larstvei";
    shell = pkgs.fish;
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
    ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "mac";
    options = "lv3:alt_switch,apple:alupckeys";
  };

  console.useXkbConfig = true;

  nixpkgs.config.allowUnfree = true;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

}
