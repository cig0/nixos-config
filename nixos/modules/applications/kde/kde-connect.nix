 { config, lib, ... }:

let
  cfg = config.mySystem.programs.kdeconnect;

in {
  options.mySystem.programs.kdeconnect = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "KDE Connect";
  };

  config = lib.mkIf (cfg == "true") {
    programs.kdeconnect = {
      enable = true;
    };
  };
}