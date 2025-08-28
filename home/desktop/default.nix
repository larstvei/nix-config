{ pkgs, zen-browser, ... }:
{

  home.packages = [
    pkgs.adwaita-icon-theme
    pkgs.brightnessctl
    pkgs.pamixer
    pkgs.rofi-wayland
    pkgs.wtype
  ];

  imports = [
    zen-browser.homeModules.beta
    ./hyprland
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
}
