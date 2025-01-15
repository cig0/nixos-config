{ config, lib, ... }:

let
  cfg = config.mySystem.services.speech-synthesis;

in {
  options.mySystem.services.speech-synthesis = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable atop, the console system performance monitor";
  };

  config = lib.mkIf (cfg == "true") {
    services.speechd.enable = true;
  };
}