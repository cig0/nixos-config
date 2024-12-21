{ config, lib, ... }:

let
  cfg = config.mySystem.guiShellEnv;

in {
  config = lib.mkIf (cfg == "plasma6") {
    programs.kde-pim = {
      enable = true;
      kmail = true;
      kontact = true;
      merkuro = true;
    };
  };
}