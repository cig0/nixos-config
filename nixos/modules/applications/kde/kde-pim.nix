# Don't remove this line! This is a NixOS applications module.

{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "programs" "kde-pim"] config;
in {
  options.mySystem.programs.kde-pim.enable = lib.mkEnableOption "Whether to enable KDE PIM base packages.";

  config = {
    programs.kde-pim = {
      enable = cfg.enable;
      kmail = true;
      kontact = true;
      merkuro = true;
    };
  };
}
