{ pkgs, ... }:
{
  fonts.packages = import ../../home/fonts { inherit pkgs; };
}
