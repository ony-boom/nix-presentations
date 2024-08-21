presentationPackage: {
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  options.presentation = {
    enable = mkEnableOption "My awesome nix presentation";

    port = mkOption {
      type = types.int;
      default = 8080;
      description = "The port on which the presentation will be served.";
    };
  };

  config = mkIf config.presentation.enable {
    services.nginx = {
      enable = true;
      virtualHosts.localhost.locations."/" = {
        root = "${presentationPackage}";
        index = "index.html";
      };
    };

    networking.firewall.allowedTCPPorts = [80 config.presentation.port];
  };
}
