{ pkgs, ... }:
with pkgs;
{
  bqn = [
    cbqn
  ];

  clojure = [
    babashka
    clj-kondo
    clojure
    leiningen
    neil
  ];

  go = [
    go
    gopls
  ];

  haskell = [
    (haskell.packages.ghc96.ghcWithPackages (
      ps: with ps; [
        QuickCheck
      ]
    ))
    cabal-install
    stack
  ];

  java = [
    jdk
    jdt-language-server
  ];

  maude = [
    maude
  ];

  minizinc = [
    minizinc
  ];

  nix = [
    nil
    nixfmt-rfc-style
  ];

  python = [
    (python3.withPackages (
      python-packages: with python-packages; [
        graphviz
        html2text
        hypothesis
        matplotlib
        numpy
        openpyxl
        pandas
        pygments
        python-lsp-server
        scikit-learn
        scipy
        xlsxwriter
        yattag
        z3
      ]
    ))
  ];

  rust = [
    cargo
    rustc
    rustfmt
    rust-analyzer
  ];

  scheme = [
    gambit
  ];

  tex = [
    texliveFull
  ];

  zig = [
    zig
    zls
  ];
}
