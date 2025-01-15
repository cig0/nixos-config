 { config, lib, ... }:

let
  cfg = config.mySystem.kde.connect;

in {
  options.mySystem.kde.connect = lib.mkOption {
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