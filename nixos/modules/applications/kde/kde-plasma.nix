{ config, lib, ... }:

let
  cfg = config.mySystem.kde.plasma;

in {
  options.mySystem.kde.plasma = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "KDE 6 Plasma Desktop";
  };

  config = lib.mkIf (cfg == "true") {
    programs.dconf.enable = true;  # https://wiki.nixos.org/wiki/KDE#Installation

    services.desktopManager.plasma6.enable = true;
  };
}