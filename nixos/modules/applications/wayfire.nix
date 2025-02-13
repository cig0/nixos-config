# Don't remove this line! This is a NixOS APPLICATIONS module.

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem.wayfire;
in
{
  options.mySystem.wayfire.enable = lib.mkEnableOption "Whether to enable Wayfire WM";

  config = lib.mkIf cfg.enable {
    programs.wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };
  };
}
