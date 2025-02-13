# Don't remove this line! This is a NixOS hardware module.

{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "hardware" "bluetooth" "enable"] config;
in {
  options.mySystem.hardware.bluetooth.enable = lib.mkEnableOption "Whether to enable the Bluetooth radio";

  config = lib.mkIf cfg {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true; # Powers up the default Bluetooth controller on boot
      };
    };
  };
}
