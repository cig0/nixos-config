{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "programs" "mtr"] config;
in {
  options.myNixos.programs.mtr.enable = lib.mkEnableOption "Whether to enable the mtr network diagnostic tool";

  config = lib.mkIf cfg.enable {
    programs.mtr.enable = true; # Network diagnostic tool
    # services.mtr-exporter.enable = hostnameLogic.isChuweiMiniPC; # Prometheus-ready exporter.
    services.mtr-exporter.enable = false; # Prometheus-ready exporter.
  };
}
# READ ME!
# ========
# https://wiki.nixos.org/wiki/Mtr

