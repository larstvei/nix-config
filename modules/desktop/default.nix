{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  theme = import ./theme;
  latitude = 59.9;
  longitude = 10.7;
  activate = path: ''
    gen=$(systemctl cat home-manager-${config.home.username}.service | awk '/^ExecStart=/ {print $2}')
    "$gen${path}"
     niri msg action load-config-file
  '';
in
{

  home.packages = [
    inputs.nanostatus.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.adwaita-icon-theme
    pkgs.brightnessctl
    pkgs.ghostty
    pkgs.libreoffice
    pkgs.pamixer
    pkgs.wl-clipboard
    pkgs.wl-mirror
    pkgs.wtype
  ]
  ++ lib.optionals (pkgs.stdenv.hostPlatform.isx86_64) [
    pkgs.google-chrome
  ];

  imports = [
    inputs.niri.homeModules.stylix
    inputs.stylix.homeModules.stylix
    inputs.zen-browser.homeModules.beta
    ./niri
    ./swayidle
    ./swaylock
    ./zen-browser
  ];

  gtk.gtk4.theme = config.gtk.theme;

  programs.zathura.enable = true;

  services.swayosd.enable = true;

  stylix = {
    enable = true;
    overlays.enable = false;
    polarity = "light";
    base16Scheme = theme.light;
    # We style zen manually.
    targets.zen-browser.enable = false;
    fonts = {
      serif = {
        package = pkgs.source-serif;
        name = "Source Serif 4";
      };
      sansSerif = {
        package = pkgs.source-sans;
        name = "Source Sans 3";
      };
      monospace = {
        package = pkgs.source-code-pro;
        name = "Source Code Pro";
      };
    };
  };

  specialisation.dark.configuration.stylix = {
    polarity = lib.mkForce "dark";
    base16Scheme = lib.mkForce theme.dark;
  };

  services.darkman = {
    enable = true;
    settings = {
      portal = true;
      lat = latitude;
      lng = longitude;
    };
    lightModeScripts.hm-specialisation = activate "/activate";
    darkModeScripts.hm-specialisation = activate "/specialisation/dark/activate";
  };

  services.wlsunset = {
    enable = true;
    latitude = latitude;
    longitude = longitude;
    temperature.night = 3000;
  };
}
