{ config, lib,  ... }:

let
  cfg = config.mySystem.programs.mtr.enable;

in {
  options.mySystem.programs.mtr.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable the mtr network diagnostic tool";
  };

  config = lib.mkIf (cfg == true) {
    programs.mtr.enable = true; # Network diagnostic tool
    # services.mtr-exporter.enable = hostnameLogic.isChuweiMiniPC; # Prometheus-ready exporter.
    services.mtr-exporter.enable = false; # Prometheus-ready exporter.
  };
}



# READ ME!
# ========

# https://wiki.nixos.org/wiki/Mtr