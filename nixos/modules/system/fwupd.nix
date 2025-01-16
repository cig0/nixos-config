{ config, lib, ... }:

let
  cfg = config.mySystem.services.fwupd.enable;

in {
  options.mySystem.services.fwupd.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable fwupd, a DBus service that allows
applications to update firmware.";
  };

  config = lib.mkIf (cfg == true) {
    services.fwupd.enable = true;
  };
}