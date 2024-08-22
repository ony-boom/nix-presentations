{
  src,
  pkgs,
  buildInputs,
}:
pkgs.stdenv.mkDerivation {
	name = "npr";
  inherit src buildInputs;

  dontUnpack = true;
  dontFixup = true;

  buildPhase = ''
    marp $src/slides.md -o index.html
  '';

  installPhase = ''
    mkdir $out
    cp index.html $out/index.html
    cp -r $src/images $out/images
  '';
}
