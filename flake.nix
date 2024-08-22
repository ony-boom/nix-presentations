{
  description = "Nix presentation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    oldNixpkgs.url = "github:nixos/nixpkgs/nixos-23.11"; # nixpkgs repo for node18
  };

  outputs = {
    self,
    nixpkgs,
    oldNixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    oldPkgs = oldNixpkgs.legacyPackages.${system};

    buildInputs = with pkgs; [marp-cli nodejs];

    presentationPackage = pkgs.stdenv.mkDerivation {
      name = "npr";
      inherit buildInputs;
      src = ./.;

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
    };

    nixosModule = import ./presentation.nix presentationPackage;
    runPresentation = pkgs.writeShellApplication {
      name = "run-presentation";
      text = ''
        ${pkgs.marp-cli}/bin/marp . -w
      '';
    };
  in {
    formatter.${system} = pkgs.alejandra;
    packages.${system}.default = presentationPackage;
    apps.${system}.default = {
      type = "app";
      program = "${runPresentation}/bin/run-presentation";
    };
    devShells.${system} = {
      default = pkgs.mkShell {
        inherit buildInputs;
      };
      multi = import ./examples/multi-version-shell.nix {inherit pkgs oldPkgs;};
    };
    nixosModules.default = nixosModule;
  };
}
