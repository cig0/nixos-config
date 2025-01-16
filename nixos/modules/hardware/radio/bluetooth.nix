{ config, lib, ... }:

let
  cfg = config.mySystem.hardware.bluetooth.enable;

in {
  options.mySystem.hardware.bluetooth.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable the Bluetooth radio";
  };

  config = lib.mkIf (cfg == true) {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true; # Powers up the default Bluetooth controller on boot
      };
    };
  };
}