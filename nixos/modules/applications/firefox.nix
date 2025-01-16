{ config, lib, ... }:

let
    cfg = config.mySystem.programs.firefox.enable;

in {
  options.mySystem.programs.firefox.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "The web browser";
  };

  config = lib.mkIf (cfg == true) {
    programs = {
      firefox = {
        enable = true;
        preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };  # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
      };
    };
  };
}