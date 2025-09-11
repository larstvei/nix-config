{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (haskell.packages.ghc96.ghcWithPackages (
      ps: with ps; [
        QuickCheck
      ]
    ))
    cabal-install
    stack
  ];
}
