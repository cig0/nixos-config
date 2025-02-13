# Don't remove this line! This is a NixOS APPLICATIONS module.

{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "programs" "firefox"] config;
in {
  options.mySystem.programs.firefox.enable = lib.mkEnableOption "Whether to enable the Firefox web browser.";

  config = {
    programs = {
      firefox = {
        enable = cfg.enable;
        preferences = {"widget.use-xdg-desktop-portal.file-picker" = "1";}; # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
      };
    };
  };
}
