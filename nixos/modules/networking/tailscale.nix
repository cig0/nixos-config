# Check these modules for additional options:
#   - ./dns.nix
#   - ../security/firewall.nix

{ ... }:

{
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--ssh" ];
  };
}