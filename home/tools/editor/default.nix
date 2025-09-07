{ pkgs, emacs-larstvei, ... }:
{
  home.packages = [
    emacs-larstvei.defaultPackage.${pkgs.system}
  ];
}
