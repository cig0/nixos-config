# Check these modules for additional options:
# ./dns.nix
# ./firewall.nix
{ ... }:

{
  services.tailscale = {
    enable = true;
  };
}