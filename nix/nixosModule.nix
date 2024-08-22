presentationPackage: {
  lib,
  config,
  ...
}: let
  cfg = config.programs.nix-presentation;
in
  with lib; {
    options.programs.nix-presentation = {
      enable = mkEnableOption "My awesome nix presentation";

      port = mkOption {
        type = types.port;
        default = 8080;
        description = "The port on which the presentation will be served.";
      };
    };

    config = mkIf cfg.enable {
      services.nginx = {
        enable = true;
        virtualHosts.localhost = {
          listen = [
            {
              addr = "0.0.0.0";
              port = cfg.port;
            }
          ];
          locations."/nix-presentation" = {
            root = "${presentationPackage}";
            index = "index.html";
          };
        };
      };

      networking.firewall.allowedTCPPorts = [cfg.port];
    };
  }
