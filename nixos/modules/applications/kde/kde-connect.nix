{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "programs" "kdeconnect"] config;
in {
  options.mySystem.programs.kdeconnect.enable = lib.mkEnableOption "Whether to enable kdeconnect.";

  config = {
    programs.kdeconnect = {
      enable = cfg.enable;
    };
  };
}
