# Check these modules for additional options:
#   - ../networking/dns.nix
#   - ../security/firewall.nix

{ config, lib, ... }:

let
  cfg = config.mySystem.tailscale;

in {
  options.mySystem.tailscale = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable Tailscale service";
  };

  config = lib.mkIf (cfg == "true") {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      extraUpFlags = [ "--ssh" ];
    };
  };
}