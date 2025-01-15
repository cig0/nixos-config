{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.wayfire;

in {
  options.mySystem.wayfire = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable Wayfire WM";
  };

  config = lib.mkIf (cfg == "true") {
    programs.wayfire = {
      enable = false;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };
  };
}