{
  description = "Lars' MacBook Pro";

  inputs = {

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";
    };

    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    # Nix-Darwin
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # HM-manager for dotfile/user management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    emacs-src = {
      url = "github:emacs-mirror/emacs";
      flake = false;
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

            config.allpwUnfree = true;

            overlays = with inputs; [
              (final: prev: {
                emacs-mac = (prev.emacs.override {
                  srcRepo = true;
                  nativeComp = true;
                  withSQLite3 = true;
                  withNS = true;
                }).overrideAttrs (o: rec {
                  version = "29.0.50";
                  src = inputs.emacs-src;

                  patches = [
                    ./patches/fix-window-role.patch
                    ./patches/my-no-titlebar.patch
                    ./patches/system-appearance.patch
                  ];
                });
              })
            ];
          };
        })
      ];
    };
  };
}
