{ config, lib, ... }:

let
  cfg = config.mySystem.hyprland;

in {
  options.mySystem.hyprland = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable Hyprland WM";
  };

  config = lib.mkIf (cfg == true) {
    programs.hyprland = {
      enable = false;
      withUWSM = true; # recommended for most users
    };
  };
}