 { config, lib, ... }:

let
  cfg = config.mySystem.programs.kdeconnect.enable;

in {
  options.mySystem.programs.kdeconnect.enable = lib.mkOption {
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