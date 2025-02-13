# Don't remove this line! This is a NixOS APPLICATIONS module.

{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "services" "tailscale"] config;
in {
  options.mySystem.services.tailscale.enable = lib.mkEnableOption "Whether to enable Tailscale client daemon.";

  config = lib.mkIf cfg.enable {
    networking = {
      firewall = {
        trustedInterfaces = lib.mkBefore ["tailscale0"];
      };
      nameservers = lib.mkBefore ["100.100.100.100"]; # TODO: 1. SOPS/ 2. Get rid of lib.mkBefore
      search = lib.mkBefore ["tuxedo-goanna.ts.net"]; # TODO: 1. SOPS/ 2. Get rid of lib.mkBefore
    };

    services = {
      openssh = {
        listenAddresses = lib.mkAfter [
          {
            addr = "100.0.0.0";
            port = 22222;
          }
        ];
      };
      tailscale = {
        enable = true;
        openFirewall = true;
        extraUpFlags = ["--ssh"];
      };
    };
  };
}
# READ ME!
# ========
# Check these modules for additional options:
#   - ../networking/dns.nix
#   - ../security/firewall.nix

