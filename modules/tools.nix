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
    ffmpeg
    graphviz
    imagemagick
    inkscape
    pdf2svg
    poppler_utils
  ];

}
