{ pkgs, emacs-larstvei, ... }:
with pkgs;
{

  editor = [
    emacs-larstvei.defaultPackage.${pkgs.system}
  ];

  spelling = [
    (hunspellWithDicts [ hunspellDicts.nb_NO ])
  ];

  # terminal = [
  #   ghostty
  # ];

  modernReplacements = [
    bat
    fd
    ripgrep
  ];

  utils = [
    jet
    jq
    pandoc
    parallel
    tokei
    wget
  ];

  multimedia = [
    dot2tex
    ffmpeg
    ghostscript
    graphviz
    imagemagick
    inkscape
    pdf2svg
    poppler_utils
  ];

  academic = [
    zotero
  ];

  learning = [
    exercism
  ];
}
