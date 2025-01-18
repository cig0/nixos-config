{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "networking" "stevenblack" "enable"] config;
in {
  options.mySystem.networking.stevenblack.enable = lib.mkEnableOption "Whether to enable the stevenblack hosts file blocklist.";

  config = lib.mkIf cfg {
    networking.stevenblack = {
      enable = true;
      block = [
        "gambling"
        "porn"
        "social"
      ];
    };
  };
}
# READ ME!
# ========
# https://github.com/StevenBlack/hosts

