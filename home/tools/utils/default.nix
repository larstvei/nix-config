{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    fd
    gnumake
    jet
    jq
    pandoc
    parallel
    ripgrep
    tokei
    wget
  ];
}
