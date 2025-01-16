{ config, lib, ... }:

let
  cfg = config.mySystem.power-management.enable;

in {
  options.mySystem.power-management.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable Power Management";
  };

  config = lib.mkIf (cfg == true) {
    powerManagement = {
      enable = true;
    };
  };
}