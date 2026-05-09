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
      inputs.home-manager.follows = "home-manager";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
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
        };
      };

      machines = {
        linux = {
          thinkpad = {
            system = "x86_64-linux";
            path = ./machines/thinkpad;
            homeModules = [
              self.homeModules.full
              self.homeModules.desktop
            ];
          };
          vm-aarch64 = {
            system = "aarch64-linux";
            path = ./machines/vm-aarch64;
            homeModules = [ self.homeModules.minimal ];
          };
        };
        darwin = {
          macbookpro = {
            system = "aarch64-darwin";
            path = ./machines/macbook;
            homeModules = [ self.homeModules.full ];
            extraModules = [
              nix-rosetta-builder.darwinModules.default
              { nix-rosetta-builder.onDemand = true; }
            ];
          };
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

      homeConfigurations =
        builtins.mapAttrs (
          name: machine:
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = machine.system;
              config.allowUnfree = true;
            };
            extraSpecialArgs = sharedArgs;
            modules = machine.homeModules ++ [
              {
                home.username = sharedArgs.user.name;
                home.homeDirectory =
                  if builtins.match ".*-darwin" machine.system != null then
                    "/Users/${sharedArgs.user.name}"
                  else
                    "/home/${sharedArgs.user.name}";
              }
            ];
          }
        ) machines.linux
        // machines.darwin;

      nixosConfigurations = builtins.mapAttrs (
        name: machine:
        nixpkgs.lib.nixosSystem {
          specialArgs = sharedArgs // {
            homeProfile = machine.homeModules;
          };
          modules = [
            home-manager.nixosModules.default
            machine.path
            { networking.hostName = name; }
          ]
          ++ (machine.extraModules or [ ]);
        }
      ) machines.linux;

      darwinConfigurations = builtins.mapAttrs (
        name: machine:
        darwin.lib.darwinSystem {
          system = machine.system;
          specialArgs = sharedArgs // {
            homeProfile = machine.homeModules;
          };
          modules = [
            home-manager.darwinModules.default
            machine.path
            { networking.hostName = name; }
          ]
          ++ (machine.extraModules or [ ]);
        }
      ) machines.darwin;
    };
}
