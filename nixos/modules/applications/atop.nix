{ config, lib, ... }:

let
  enabled = config.mySystem.programs.atop;

in {
  options.mySystem.programs.atop = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable atop, the console system performance monitor";
  };

  config = lib.mkIf (enabled == "true") {
    programs.atop = {
      enable = true;
    };
  };
}