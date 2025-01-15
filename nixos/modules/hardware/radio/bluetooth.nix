{ config, lib, ... }:

let
  cfg = config.mySystem.hardware.bluetooth;

in {
  options.mySystem.hardware.bluetooth = lib.mkOption {
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