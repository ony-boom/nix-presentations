{
  description = "Nix presentation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    oldNixpkgs.url = "github:nixos/nixpkgs/nixos-23.11"; # nixpkgs repo for node18
  };

  # all inputs is passed down to this output as parameters
  outputs = {
    nixpkgs,
    oldNixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    oldPkgs = oldNixpkgs.legacyPackages.${system};

    buildInputs = with pkgs; [marp-cli nodejs];

    presentationPackage = import ./nix/package.nix {
      inherit pkgs buildInputs;
      src = ./.;
    };

    runPresentation = pkgs.writeShellApplication {
      name = "run-presentation";
      text = ''
        ${pkgs.marp-cli}/bin/marp . -w
      '';
    };
  in {
    # format all nix module
    formatter.${system} = pkgs.alejandra;

    # the actual package that gonna be returned when `nix build`
    # for this case the package will be the slides as html and all the images
    packages.${system}.default = presentationPackage;

    # we can run program directly using `nix run`
    # This will run the presentation
    apps.${system}.default = {
      type = "app";
      program = "${runPresentation}/bin/run-presentation";
    };

    # A list of dev environment
    devShells.${system} = {
      default = pkgs.mkShell {
        packages = buildInputs;
      };
      multi = import ./nix/multi-version-shell.nix {inherit pkgs oldPkgs;};
    };

    # nixos configuration module
    nixosModules.default = import ./nix/nixosModule.nix presentationPackage;
  };
}
