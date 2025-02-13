# Don't remove this line! This is a NixOS hardware module.

{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "services" "thermald"] config;
in {
  options.mySystem.services.thermald = {enable = lib.mkEnableOption "Whether to enable thermald";};

  config = {
    services.thermald.enable = cfg.enable;
  };
}
