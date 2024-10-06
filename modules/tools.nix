{ pkgs, emacs-larstvei, ... }:
with pkgs; {

  editor = [
    emacs-larstvei.defaultPackage.${pkgs.system}
  ];

  spelling = [
    (hunspellWithDicts [ hunspellDicts.nb_NO ])
  ];

  modernReplacements = [
    bat
    fd
    ripgrep
  ];

  utils = [
    cloc
    jet
    jq
    pandoc
    parallel
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
