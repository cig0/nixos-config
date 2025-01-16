{ config, lib, ... }:

let
  cfg = config.mySystem.services.speech-synthesis.enable;

in {
  options.mySystem.services.speech-synthesis.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable atop, the console system performance monitor";
  };

  config = lib.mkIf (cfg == true) {
    services.speechd.enable = true;
  };
}