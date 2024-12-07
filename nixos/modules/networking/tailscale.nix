# Check these modules for additional options:
#   - ./dns.nix
#   - ../security/firewall.nix

{ ... }:

{
  services.tailscale = {
    openFirewall = true;
    enable = true;
    extraUpFlags = [ "--ssh" ];
  };
}