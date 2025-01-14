 { config, lib, ... }:

let
  cfg = config.mySystem.guiShellEnv;

in {
  config = lib.mkIf (cfg == "plasma6") {
    programs.kdeconnect = {
      enable = true;
    };
  };
}