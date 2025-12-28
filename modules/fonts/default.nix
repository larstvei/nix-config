{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      iosevka
      source-code-pro
      source-sans
      source-serif
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif 4" ];
        sansSerif = [ "Source Sans 3" ];
        monospace = [ "Source Code Pro" ];
      };
    };
  };

}
