presentationPackage: {
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  options.presentation = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the presentation service.";
    };

    src = mkOption {
      type = types.path;
      description = "The source path for the presentation markdown and assets.";
    };

    port = mkOption {
      type = types.int;
      default = 8080;
      description = "The port on which the presentation will be served.";
    };
  };

  config = mkIf config.presentation.enable {
    services.nginx.enable = true;
    services.nginx.virtualHosts.localhost = {
      root = "${presentationPackage}";
      listen = [
        {
          addr = "0.0.0.0";
          port = config.presentation.port;
        }
      ];
      index = "index.html";
    };

    networking.firewall.allowedTCPPorts = [config.presentation.port];
  };
}
