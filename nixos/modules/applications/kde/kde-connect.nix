 { config, lib, ... }:

let
  cfg = config.mySystem.programs.kdeconnect;

in {
  options.mySystem.programs.kdeconnect = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "KDE Connect";
  };

  config = {
    programs.kdeconnect = {
      enable = cfg;
    };
  };
}