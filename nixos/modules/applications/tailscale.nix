{ config, lib, ... }:

let
  cfg = config.mySystem.services.tailscale.enable;

in {
  options.mySystem.services.tailscale.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable Tailscale service";
  };

  config = lib.mkIf (cfg == true) {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      extraUpFlags = [ "--ssh" ];
    };
  };
}



# READ ME!
# ========

# Check these modules for additional options:
#   - ../networking/dns.nix
#   - ../security/firewall.nix