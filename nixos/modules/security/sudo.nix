{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem.security.sudo.enable;
in {
  options.mySystem.security.sudo.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable sudo";
  };

  config = lib.mkIf (cfg == true) {
    security.sudo = {
      enable = true;
      execWheelOnly = true;
    };
  };
}
# READ ME!
# ========
# Hardening tips: https://xeiaso.net/blog/paranoid-nixos-2021-07-18/

