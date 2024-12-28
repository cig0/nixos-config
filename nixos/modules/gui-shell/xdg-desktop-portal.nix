# Enable XDG desktop integration for other desktops toolkits.

{ pkgs, ... }:

{
  xdg = {
    portal = {
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