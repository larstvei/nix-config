{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.emacs-larstvei.defaultPackage.${pkgs.stdenv.hostPlatform.system}
  ];
}
