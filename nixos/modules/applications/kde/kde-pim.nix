{ config, lib, ... }:

let
  enabled = config.mySystem.guiShellEnv;

in {
  config = lib.mkIf (enabled == "plasma6") {
    programs.kde-pim = {
      enable = true;
      kmail = true;
      kontact = true;
      merkuro = true;
    };
  };
}