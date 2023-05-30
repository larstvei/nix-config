{
  description = "Lars' MacBook Pro";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    emacs = {
      url = "github:nix-community/emacs-overlay";
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
              emacs.overlays.emacs
              emacs.overlays.package
              (final: prev: {
                emacsGit = (prev.emacsGit.override {
                  withXwidgets = true;
                  withGTK3 = true;
                }).overrideAttrs (o: rec {
                  buildInputs = o.buildInputs ++ [ prev.darwin.apple_sdk.frameworks.WebKit ];
                  patches = [
                    ./patches/no-titlebar-rounded-corners.patch
                    ./patches/system-appearance.patch
                  ];
                });
                maude-mac = final.callPackage ./pkgs/maude-mac { };
              })
            ];
          };
        })
      ];
    };
  };
}
