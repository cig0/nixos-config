# firefox.nix - Firefox Web Browser

{ config, lib, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hosts = import ../../helpers/hostnames.nix { inherit config lib; };
in
{
  # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
  programs = {
    firefox = {
      enable = false;
      preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };
    };
  };
}