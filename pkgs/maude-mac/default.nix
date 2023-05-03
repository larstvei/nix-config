{ lib, stdenv, fetchurl, unzip, ... }:

stdenv.mkDerivation rec {
  pname = "maude";
  version = "3.3";

  src = fetchurl {
    url = "https://github.com/SRI-CSL/Maude/releases/download/Maude${version}/Maude-macos.zip";
    sha256 = "sha256-ulo4zdmBJQYjvlsmS5L5uhmsxIKzLJ2BKE+mwJYMnbE=";
  };

  nativeBuildInputs = [ unzip ];

  installPhase = ''
    mkdir -p $out/bin
    cp *.maude $out/bin/
    cp maude.Darwin64 $out/bin/maude
  '';

  meta = with lib; {
    homepage = "http://maude.cs.illinois.edu/";
    description = "High-level specification language";
    license = lib.licenses.gpl2Plus;

    longDescription = ''
      Maude is a high-performance reflective language and system
      supporting both equational and rewriting logic specification and
      programming for a wide range of applications. Maude has been
      influenced in important ways by the OBJ3 language, which can be
      regarded as an equational logic sublanguage. Besides supporting
      equational specification and programming, Maude also supports
      rewriting logic computation.
    '';

    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = platforms.darwin;
    maintainers = with maintainers; [ larstvei ];
  };
}
