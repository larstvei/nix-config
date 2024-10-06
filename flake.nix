{
  description = "My nix configuration.";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    {
      darwin,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      homeConfig = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.larstvei = {
            imports = [
              { _module.args = inputs; }
              ./modules/home.nix
            ];
          };
        };
      };
    in
    {
      darwinConfigurations."larstvei-macbookpro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          ./hosts/darwin-m1/configuration.nix
          ./modules/core.nix

          home-manager.darwinModule
          homeConfig
        ];
      };

      nixosConfigurations."larstvei-nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Or "aarch64-linux" for ARM systems

        modules = [
          ./hosts/nixos-intel-mbp/configuration.nix
          ./modules/core.nix

          home-manager.nixosModule
          homeConfig
        ];
      };
    };
}
