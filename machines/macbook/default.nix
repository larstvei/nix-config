{ pkgs, inputs, ... }:
{
  imports = [
    ../../modules/base
    ../../modules/darwin
  ];

  system.primaryUser = "larstvei";

  networking.hostName = "larstvei-macbookpro";

  users.users.larstvei = {
    home = "/Users/larstvei";
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.larstvei.imports = [ ../../modules/home/full ];
  };
}
