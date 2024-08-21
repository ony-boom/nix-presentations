{
  description = "Nix presentation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    buildInputs = with pkgs; [marp-cli nodejs];
  in {
    formatter.${system} = pkgs.alejandra;
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      name = "npr";
      inherit buildInputs;
      src = ./.;

      dontUnpack = true;
			dontFixup = true;

      buildPhase = ''
        marp $src/slides.md -o index.html
      '';

      installPhase = ''
        mkdir -p $out/bin
			
        cp index.html $out/index.html
        cp -r $src/images $out/images

        echo "#! ${pkgs.stdenv.shell}" >> "$out/bin/npr"
				echo "cd $out" >> "$out/bin/npr"
        echo "${pkgs.http-server}/bin/http-server -o" >> "$out/bin/npr"
        
        chmod 0755 "$out/bin/npr"
      '';
    };
    devShells.${system}.default = pkgs.mkShell {
      inherit buildInputs;
    };
  };
}
