{
  pkgs,
  oldPkgs,
}:
pkgs.mkShell {
  shellHook = ''
    alias node18="${oldPkgs.nodejs}/bin/node"
    alias ltsNode="${pkgs.nodejs}/bin/node"
  '';
  packages = [pkgs.nodejs oldPkgs.nodejs];
}
