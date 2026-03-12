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
      self,
      darwin,
      nixpkgs,
      home-manager,
      nix-rosetta-builder,
      ...
    }@inputs:
    let
      sharedArgs = {
        inherit inputs self;
        user = {
          name = "larstvei";
          email = "larstvei@ifi.uio.no";
          fullName = "Lars Tveito";
          smtpUser = "larstvei@uio.no";
        };
      };
    in
    {
      nixosModules = {
        base = ./modules/base;
        nixos = ./modules/nixos;
        graphical = ./modules/nixos/graphical;
      };

      homeModules = {
        full = ./modules/home/full;
        desktop = ./modules/desktop;
        minimal = ./modules/home/minimal;
      };

      darwinModules = {
        base = ./modules/darwin;
      };

      darwinConfigurations.larstvei-macbookpro = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = sharedArgs;
        modules = [
          home-manager.darwinModules.default
          ./machines/macbook
          nix-rosetta-builder.darwinModules.default
          { nix-rosetta-builder.onDemand = true; }
        ];
      };

      nixosConfigurations =
        let
          mkLinux =
            system: path:
            nixpkgs.lib.nixosSystem {
              system = system;
              specialArgs = sharedArgs;
              modules = [
                home-manager.nixosModules.default
                path
              ];
            };
        in
        {
          thinkpad = mkLinux "x86_64-linux" ./machines/thinkpad;
          vm-aarch64 = mkLinux "aarch64-linux" ./machines/vm-aarch64;
        };
    };
}
