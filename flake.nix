{
  description = "Lars' MacBook Pro";

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
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs: {
    darwinConfigurations."larstvei-macbookpro" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      modules = [
        ./modules/mac.nix
        home-manager.darwinModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.larstvei = {
              imports = [
                ./modules/home.nix
              ];
            };
          };
        }
        ({ config, pkgs, lib, ... }: {
          services.nix-daemon.enable = true;

          nixpkgs = {
            config.allowUnfree = true;
            overlays = with inputs; [
              (final: prev: {
                maude-mac = final.callPackage ./pkgs/maude-mac { };
              })
            ];
          };
        })
      ];
    };
  };
}
