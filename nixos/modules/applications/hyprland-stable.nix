# Don't remove this line! This is a NixOS APPLICATIONS module.

{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem.hyprland;
in {
  options.mySystem.hyprland.enable = lib.mkEnableOption "Whether to enable Hyprland WM";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = false;
      withUWSM = true; # recommended for most users
    };
  };
}
