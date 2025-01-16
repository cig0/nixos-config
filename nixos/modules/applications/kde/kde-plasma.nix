{ config, lib, ... }:

let
  cfg = config.mySystem.services.desktopManager.plasma6.enable;

in {
  options.mySystem.services.desktopManager.plasma6.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "KDE 6 Plasma Desktop Environment.";
  };

  config = lib.mkIf (cfg == true) {
    programs.dconf.enable = true;  # https://wiki.nixos.org/wiki/KDE#Installation
    services.desktopManager.plasma6.enable = true;
  };
}