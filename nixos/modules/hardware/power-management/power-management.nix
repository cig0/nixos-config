{ config, lib, ... }:

let
  cfg = config.mySystem.power-management;

in {
  options.mySystem.power-management = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable Power Management";
  };

  config = lib.mkIf (cfg == "true") {
    powerManagement = {
      enable = true;
    };
  };
}