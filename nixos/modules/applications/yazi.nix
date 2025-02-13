# Don't remove this line! This is a NixOS applications module.

# TODO: configure Yazi
{ config, lib, ... }:
let
  cfg = config.mySystem.programs.yazi;
in
{
  options.mySystem.programs.yazi = {
    enable = lib.mkEnableOption "Whether to enable Yazi terminal file manager.";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
    };
  };
}
