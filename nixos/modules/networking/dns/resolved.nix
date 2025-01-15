{ config, lib,  ... }:

let
  cfg = config.mySystem.services.resolved;

in {
  options.mySystem.services.resolved = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Wheteher to use the resolved systemd service";
  };

  config = lib.mkIf (cfg == "true") {
    services.resolved = {
      enable = true;
      fallbackDns = [ "1.1.1.1" "208.67.222.123" "8.8.8.8" ];
    };
  };
}