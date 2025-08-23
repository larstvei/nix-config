{ emacs-larstvei, ... }:
{
  imports = [
    ../../modules/core.nix
    ../../modules/macos.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit emacs-larstvei; };
    users.larstvei.imports = [ ../../modules/home.nix ];
  };
}
