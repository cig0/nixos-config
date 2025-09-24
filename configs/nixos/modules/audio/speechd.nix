{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "services" "speechd"] config;
in {
  options.myNixos.services.speechd.enable = lib.mkEnableOption "Whether to enable speech-dispatcher speech synthesizer daemon.";

  config = {
    services.speechd.enable = cfg.enable;
  };
}
