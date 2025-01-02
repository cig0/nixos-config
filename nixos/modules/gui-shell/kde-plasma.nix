{ config, lib, ... }:

let
  cfg = config.mySystem.guiShellEnv;
in {
  config = lib.mkIf (cfg == "plasma6") {
    programs.dconf.enable = true;  # https://wiki.nixos.org/wiki/KDE#Installation

    services.desktopManager.plasma6.enable = true;
  };
}