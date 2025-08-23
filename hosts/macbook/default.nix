{ emacs-larstvei, ... }:
{
  imports = [
    ../../system
    ../../system/darwin
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit emacs-larstvei; };
    users.larstvei.imports = [ ../../home ];
  };
}
