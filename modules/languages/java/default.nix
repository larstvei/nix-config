{ pkgs, ... }:
{
  # Sets JAVA_HOME environment variable
  programs.java.enable = true;

  home.packages = with pkgs; [
    jdk
    jdt-language-server
  ];
}
