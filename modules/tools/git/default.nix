{ pkgs, user, ... }:
{
  programs.git = {
    enable = true;
    settings.user = {
      name = user.name;
      email = user.email;
    };
    ignores = [
      ".envrc"
      ".DS_Store"
      ".direnv"
    ];
  };

  home.packages = with pkgs; [
    gh
  ];
}
