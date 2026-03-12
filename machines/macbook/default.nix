{
  self,
  pkgs,
  inputs,
  user,
  ...
}:
{
  imports = [
    self.nixosModules.base
    self.darwinModules.base
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
    extraSpecialArgs = { inherit inputs user; };
    users.larstvei.imports = [ self.homeModules.full ];
  };
}
