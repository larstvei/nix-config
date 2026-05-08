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

  system.primaryUser = user.name;

  users.users.${user.name} = {
    home = "/Users/${user.name}";
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs user; };
    users.${user.name}.imports = [ self.homeModules.full ];
  };
}
