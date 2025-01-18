{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "services" "speechd"] config;
in {
  options.mySystem.services.speechd.enable = lib.mkEnableOption "Whether to enable speech-dispatcher speech synthesizer daemon.";

  config = {
    services.speechd.enable = cfg.enable;
  };
}
