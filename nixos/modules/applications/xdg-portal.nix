{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.xdg.portal;

in {
  options.mySystem.xdg.portal = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable XDG desktop integration for other desktop toolkits";
  };

  config = lib.mkIf (cfg == true) {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-kde  # Temporarily disabled as it installing rusty Plasma5 dependencies.
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        # xdg-desktop-portal
      ];
    };
  };
}