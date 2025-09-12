{
  pkgs,
  nanostatus,
  emacs-larstvei,
  zen-browser,
  ...
}:
{

  imports = [
    ../fonts
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit nanostatus emacs-larstvei zen-browser; };
    users.larstvei.imports = [
      ../home
      ../desktop
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

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif 4" ];
        sansSerif = [ "Source Sans 3" ];
        monospace = [ "Source Code Pro" ];
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.hyprland."org.freedesktop.impl.portal.Settings" = "darkman";
  };

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
