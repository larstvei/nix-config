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
    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-larstvei.url = "github:larstvei/dot-emacs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, kmonad, emacs-larstvei, ... }@inputs: {
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
                { _module.args = inputs; } # <- one could ask, why?
                ./modules/home.nix
              ];
            };
          };
        }
        ({ config, pkgs, lib, ... }: {
          services.nix-daemon.enable = true;
        })
      ];
    };
  };
}
