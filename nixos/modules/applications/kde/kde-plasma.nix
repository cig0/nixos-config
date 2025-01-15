{ config, lib, ... }:

let
  cfg = config.mySystem.services.desktopManager.plasma6;

in {
  options.mySystem.services.desktopManager.plasma6 = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "KDE 6 Plasma Desktop";
  };

  config = lib.mkIf (cfg == "true") {
    programs.dconf.enable = true;  # https://wiki.nixos.org/wiki/KDE#Installation

    services.desktopManager.plasma6.enable = true;
  };
}