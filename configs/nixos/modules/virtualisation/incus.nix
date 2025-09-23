{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "virtualisation" "incus"] config;
in {
  options.myNixos.virtualisation.incus.enable = lib.mkEnableOption "Whether to enable LXD fork (Linux containers)";

  config = lib.mkIf cfg.enable {
    virtualisation.incus = {
      enable = true;
      socketActivation = true;
      startTimeout = 120;
    };
  };
}
