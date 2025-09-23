{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "myNixos" "xdg" "portal" ] config;
in
{
  options.myNixos.xdg.portal.enable =
    lib.mkEnableOption "Whether to enable [xdg desktop integration](https://github.com/flatpak/xdg-desktop-portal).";

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-kde # WIP: Temporarily disabled as it installing rusty Plasma5 dependencies.
        xdg-desktop-portal-wlr
        # xdg-desktop-portal-gtk
        # xdg-desktop-portal
      ];
    };
  };
}
