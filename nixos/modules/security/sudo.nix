{ config, lib, ... }:

let
  cfg = config.mySystem.security.sudo;

in {
  options.mySystem.security.sudo = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable sudo";
  };

  config = lib.mkIf (cfg == "true") {
    security.sudo = {
      enable = true;
      execWheelOnly = true;
    };
  };
}



# READ ME!
# ========

# Hardening tips: https://xeiaso.net/blog/paranoid-nixos-2021-07-18/