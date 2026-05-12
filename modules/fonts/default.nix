{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      iosevka
      nerd-fonts.sauce-code-pro
      source-sans
      source-serif
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif 4" ];
        sansSerif = [ "Source Sans 3" ];
        monospace = [ "SauceCodePro Nerd Font" ];
      };
    };
  };
}
