{
  programs.git = {
    enable = true;
    settings.user = {
      name = "larstvei";
      email = "larstvei@ifi.uio.no";
    };
    ignores = [
      ".envrc"
      ".DS_Store"
      ".direnv"
    ];
  };
}
