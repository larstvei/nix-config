{ pkgs, emacs-larstvei, ... }:
let
  # Ghostscript has a name collision with gambit (scheme). Let's nuke the
  # offending binary, as gsc most likely unused on my system.
  ghostscriptNoGsc = pkgs.symlinkJoin {
    name = "ghostscript-no-gsc";
    paths = [ pkgs.ghostscript ];
    postBuild = ''
      rm -f $out/bin/gsc
    '';
  };
in
with pkgs;
{

  editor = [
    emacs-larstvei.defaultPackage.${pkgs.system}
  ];

  spelling = [
    hunspell
    hunspellDicts.en_US
    hunspellDicts.nb_NO
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
    ghostscriptNoGsc
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
