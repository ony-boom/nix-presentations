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
      root = "${presentationPackage}";
      virtualHosts.localhost.locations."/" = {
        index = "index.html";
      };
    };

    networking.firewall.allowedTCPPorts = [80 config.presentation.port];
    virtualisation.forwardPorts = [
      {
        from = "host";
        guest.port = 80;
        host.port = config.presentation.port;
      }
    ];
  };
}
