{ pkgs, ... }:
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
{
  home.packages = with pkgs; [
    dot2tex
    ffmpeg
    ghostscriptNoGsc
    graphviz
    imagemagick
    inkscape
    pdf2svg
    poppler_utils
  ];
}
