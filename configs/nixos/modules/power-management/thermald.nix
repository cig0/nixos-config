{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "services" "thermald"] config;
in {
  options.myNixos.services.thermald = {enable = lib.mkEnableOption "Whether to enable thermald";};

  config = {
    services.thermald.enable = cfg.enable;
  };
}
