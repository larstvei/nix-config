{ pkgs, zen-browser, ... }:
{
  imports = [
    zen-browser.homeModules.beta
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

  home.packages = [ pkgs.rofi-wayland ];
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Mod key (SUPER)
      "$mod" = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, E, exec, emacsclient -c"
        "$mod, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$shiftMod, H, movewindow, l"
        "$shiftMod, J, movewindow, d"
        "$shiftMod, K, movewindow, u"
        "$shiftMod, L, movewindow, r"
      ];
    };
  };
}
