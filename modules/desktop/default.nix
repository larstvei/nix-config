{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  theme = import ./theme;
  latitude = 59.9;
  longitude = 10.7;
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
    inputs.zen-browser.homeModules.beta
    ./niri
    ./swayidle
    ./swaylock
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;

      AutofillAddressesEnabled = false;
      AutoFillCreditCardEnabled = false;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableSetDesktopBackground = true;
      DontCheckDefaultBrowser = true;
      HomepageURL = "https://start.hadi.diy";
      StartPage = "homepage";
      NewTabPage = true;
      OfferToSaveLogins = false;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      recolor-lightcolor = "#${theme.bg.dark}";
      recolor-darkcolor = "#${theme.fg.dark}";
    };
  };

  services.swayosd.enable = true;

  services.darkman = {
    enable = true;
    settings = {
      portal = true;
      lat = latitude;
      lng = longitude;
    };
  };

  services.wlsunset = {
    enable = true;
    latitude = latitude;
    longitude = longitude;
    temperature.night = 3000;
  };
}
