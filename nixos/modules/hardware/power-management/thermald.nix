{ config, lib, ... }:

let
  cfg = config.mySystem.services.thermald.enable;

in {
  options.mySystem.services.thermald.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable thermald";
  };

  config = lib.mkIf (cfg == true) {
    services.thermald.enable = true;
  };
}
