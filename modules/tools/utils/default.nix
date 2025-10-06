{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    fd
    gnumake
    jet
    jq
    localsend
    pandoc
    parallel
    ripgrep
    tokei
    unzip
    wget
  ];
}
