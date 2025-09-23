{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "atop"] config;
in {
  options.myNixos.atop.enable = lib.mkEnableOption "Whether to enable Atop, a tool for monitoring system resources.";

  config = {
    programs.atop = {
      enable = cfg.enable;
    };
  };
}
