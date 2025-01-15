{ config, lib,  ... }:

let
  cfg = config.mySystem.mtr;

in {
  options.mySystem.mtr = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable the mtr network diagnostic tool";
  };

  config = lib.mkIf (cfg == "true") {
    programs.mtr.enable = true; # Network diagnostic tool
    # services.mtr-exporter.enable = hostnameLogic.isChuweiMiniPC; # Prometheus-ready exporter.
    services.mtr-exporter.enable = false; # Prometheus-ready exporter.
  };
}



# READ ME!
# ========

# https://wiki.nixos.org/wiki/Mtr