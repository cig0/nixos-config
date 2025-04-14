{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "powerManagement"] config;
in {
  options.myNixos.powerManagement.enable = lib.mkEnableOption "Whether to enable power management.  This includes support
for suspend-to-RAM and powersave features on laptops.";

  config = {
    powerManagement = {
      enable = cfg.enable;
    };
  };
}
