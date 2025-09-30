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
    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nanostatus.url = "github:larstvei/nanostatus";
    emacs-larstvei.url = "github:larstvei/emacs-flake";
  };

  outputs =
    {
      darwin,
      nixpkgs,
      home-manager,
      nix-rosetta-builder,
      ...
    }@inputs:
    {
      darwinConfigurations = {
        larstvei-macbookpro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";

          specialArgs = { inherit inputs; };

          modules = [
            home-manager.darwinModules.default
            ./machines/macbook
            nix-rosetta-builder.darwinModules.default
            { nix-rosetta-builder.onDemand = true; }
          ];
        };
      };

      nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.default
          ./machines/thinkpad
        ];
      };
    };
}
