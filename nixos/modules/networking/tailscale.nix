# Check these modules for additional options:
#   - ./dns.nix
#   - ../security/firewall.nix

{ config, lib, ... }:

let
  cfg = config.mySystem.services.tailscale;

in {
  options.mySystem.services.tailscale = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable Tailscale service";
  };

  config = lib.mkIf (cfg == "true") {
    services.tailscale = {
      openFirewall = true;
      enable = true;
      extraUpFlags = [ "--ssh" ];
    };
  };
}