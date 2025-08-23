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
    emacs-larstvei.url = "github:larstvei/emacs-flake";
  };

  outputs =
    {
      darwin,
      home-manager,
      nix-rosetta-builder,
      emacs-larstvei,
      ...
    }:
    {
      darwinConfigurations = {
        larstvei-macbookpro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";

          specialArgs = { inherit emacs-larstvei; };

          modules = [
            home-manager.darwinModules.default
            ./hosts/macbook
            nix-rosetta-builder.darwinModules.default
            { nix-rosetta-builder.onDemand = true; }
          ];
        };
      };
    };
}
