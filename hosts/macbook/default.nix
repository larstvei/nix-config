{ emacs-larstvei, ... }:
{
  imports = [
    ../../system
    ../../system/darwin
  ];

  networking.hostName = "larstvei-macbookpro";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit emacs-larstvei; };
    users.larstvei.imports = [ ../../home ];
  };
}
