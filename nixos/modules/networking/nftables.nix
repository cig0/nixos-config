{ config, lib, ... }:

let
  cfg = config.mySystem.networking.nftables;

in {
  options.mySystem.networking.nftables = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable use of nftables";
  };

  config = lib.mkIf (cfg == true) {
    networking.nftables.enable = true;  # Required by Incus.
  };
}