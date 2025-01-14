{ config, lib, ... }:

let
    cfg = config.mySystem.firefox;

in {
  options.mySystem.firefox = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "The web browser";
  };

  config = lib.mkIf (cfg == "true") {
    programs = {
      firefox = {
        enable = true;
        preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };  # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
      };
    };
  };
}