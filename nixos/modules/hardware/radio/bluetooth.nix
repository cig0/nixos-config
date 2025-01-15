{ config, lib, ... }:

let
  cfg = config.mySystem.bluetooth;

in {
  options.mySystem.bluetooth = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable the Bluetooth radio";
  };

  config = lib.mkIf (cfg == "true") {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true; # Powers up the default Bluetooth controller on boot
      };
    };
  };
}