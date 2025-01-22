{
  description = "My nix configuration.";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/041c867bad68dfe34b78b2813028a2e2ea70a23c";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-larstvei.url = "github:larstvei/emacs-flake";
  };

  outputs =
    { darwin, home-manager, ... }@inputs:
    {
      darwinConfigurations."larstvei-macbookpro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          ./modules/core.nix
          ./modules/macos.nix

          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.larstvei = {
                imports = [
                  { _module.args = inputs; } # <- one could ask, why?
                  ./modules/home.nix
                ];
              };
            };
          }
        ];
      };
    };
}
