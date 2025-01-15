{ config, lib, ... }:

let
  cfg = config.mySystem.services.thermald;

in {
  options.mySystem.services.thermald = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable thermald";
  };

  config = lib.mkIf (cfg == "true") {
    services.thermald.enable = true;
  };
}
