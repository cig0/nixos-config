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
      # "https://yazi-rs.github.io/docs/tips/"
      # plugins = {
      #   toggle-pane = "yazi-rs/plugins:toggle-pane";
      # };
    };
  };
}
