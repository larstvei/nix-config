{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    iosevka
    source-code-pro
    source-sans
    source-serif
  ];
}
