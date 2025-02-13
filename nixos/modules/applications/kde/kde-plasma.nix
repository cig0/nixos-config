# Don't remove this line! This is a NixOS APPLICATIONS module.

{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "services" "desktopManager" "plasma6"] config;
in {
  options.mySystem.services.desktopManager.plasma6.enable = lib.mkEnableOption "Enable the Plasma 6 (KDE 6) desktop environment.";

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true; # https://wiki.nixos.org/wiki/KDE#Installation
    services.desktopManager.plasma6.enable = true;
  };
}
