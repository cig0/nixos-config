{ config, lib, ... }:

let
  cfg = config.mySystem.atop;

in {
  options.mySystem.atop = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable atop, the console system performance monitor";
  };

  config = lib.mkIf (cfg == true) {
    programs.atop = {
      enable = true;
    };
  };
}