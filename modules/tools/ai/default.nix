{ pkgs, ... }:
{
  home.packages = with pkgs; [
    claude-code
  ];
  programs.git.ignores = [ ".claude" ];
}
