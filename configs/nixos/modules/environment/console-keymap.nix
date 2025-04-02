{ config, lib, ... }:

let
  cfg = config.mySystem.console.keyMap;

in {
  options.mySystem.console.keyMap = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = "us-acentos";
    description = "Set console key layout";
  };

  config = {
    console.keyMap = cfg;
  };
}