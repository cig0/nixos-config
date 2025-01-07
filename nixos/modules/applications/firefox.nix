{ config, lib, ... }:

let
    hostSelector = import ../../lib/host-selector.nix { inherit config lib; };

in {
  # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
  config = lib.mkIf (hostSelector.isRoleGraphical) {
    programs = {
      firefox = {
        enable = true;
        preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };
      };
    };
  };
}