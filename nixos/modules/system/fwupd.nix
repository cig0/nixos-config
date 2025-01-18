{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "services" "fwupd"] config;
in {
  options.mySystem.services.fwupd.enable = lib.mkEnableOption "Whether to enable fwupd, a DBus service that allows
applications to update firmware.";

  config = {
    services.fwupd.enable = cfg.enable;
  };
}
