{ config, lib, ... }:

let
  cfg = config.mySystem.programs.kde-pim;

in {
  options.mySystem.programs.kde-pim = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "KDE Personal Information Management suite";
  };

  config = lib.mkIf (cfg == true) {
    programs.kde-pim = {
      enable = true;
      kmail = true;
      kontact = true;
      merkuro = true;
    };
  };
}