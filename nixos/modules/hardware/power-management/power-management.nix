# Don't remove this line! This is a NixOS hardware module.

{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "powerManagement"] config;
in {
  options.mySystem.powerManagement.enable = lib.mkEnableOption "Whether to enable power management.  This includes support
for suspend-to-RAM and powersave features on laptops.";

  config = {
    powerManagement = {
      enable = cfg.enable;
    };
  };
}
