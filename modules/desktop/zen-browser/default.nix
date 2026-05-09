{ inputs, lib, ... }:
let
  theme = import ../theme;
  stylixTemplate = import "${inputs.stylix}/modules/zen-browser/userChrome.nix";
  colors = lib.mapAttrs' (n: _: {
    name = "${n}-hex";
    value = "light-dark(#${theme.light.${n}}, #${theme.dark.${n}})";
  }) theme.light;
  css = stylixTemplate { inherit colors; };
  zenChrome = builtins.replaceStrings [ "#light-dark(" ] [ "light-dark(" ] css;
in
{
  programs.zen-browser = {
    enable = true;
    profiles.main = {
      isDefault = true;
      userChrome = zenChrome;
    };
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      AutofillAddressesEnabled = false;
      AutoFillCreditCardEnabled = false;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableSetDesktopBackground = true;
      DontCheckDefaultBrowser = true;
      StartPage = "homepage";
      NewTabPage = true;
      OfferToSaveLogins = false;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };
}
