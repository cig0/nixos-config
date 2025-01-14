 { config, lib, ... }:

let
  enabled = config.mySystem.guiShellEnv;

in {
  config = lib.mkIf (enabled == "plasma6") {
    programs.kdeconnect = {
      enable = true;
    };
  };
}