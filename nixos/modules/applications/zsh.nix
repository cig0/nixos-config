# Bare configuration, as we're using the Home Manager to fully configure Zsh.

{ config, lib, ... }:

let
  cfg = config.mySystem.zsh;

in {
  options.mySystem.zsh = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to set Zsh as the default system shell";
  };

  config = lib.mkIf (cfg == "true") {
    programs.zsh.enable = true;
  };
}