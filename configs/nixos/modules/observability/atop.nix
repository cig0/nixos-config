{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "atop"] config;
in {
  options.mySystem.atop.enable = lib.mkEnableOption "Whether to enable Atop, a tool for monitoring system resources.";

  config = {
    programs.atop = {
      enable = cfg.enable;
    };
  };
}
