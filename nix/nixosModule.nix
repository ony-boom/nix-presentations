presentationPackage: {
  lib,
  config,
  ...
}:
with lib; {
  options.presentation = {
    enable = mkEnableOption "My awesome nix presentation";

    port = mkOption {
      type = types.port;
      default = 8080;
      description = "The port on which the presentation will be served.";
    };
  };

  config = mkIf config.presentation.enable {
    services.nginx = {
      enable = true;
      virtualHosts.localhost = {
        listen = [
          {
            addr = "0.0.0.0";
            port = config.presentation.port;
          }
        ];
        locations."/" = {
          root = "${presentationPackage}";
          index = "index.html";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [config.presentation.port];
  };
}
