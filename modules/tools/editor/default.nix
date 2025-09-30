{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.emacs-larstvei.defaultPackage.${pkgs.system}
  ];
}
