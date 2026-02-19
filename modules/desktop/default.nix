{
  pkgs,
  lib,
  inputs,
  ...
}:
{

  home.packages = [
    pkgs.adwaita-icon-theme
    pkgs.brightnessctl
    pkgs.grimblast
    pkgs.libreoffice
    pkgs.pamixer
    pkgs.wl-clipboard
    pkgs.wtype
  ]
  ++ lib.optionals (pkgs.stdenv.hostPlatform.isx86_64) [
    pkgs.google-chrome
  ];

  imports = [
    inputs.zen-browser.homeModules.beta
    ./hypr
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

  services.darkman = {
    enable = true;
    settings.portal = true;
  };
}
