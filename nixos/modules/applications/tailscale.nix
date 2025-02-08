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
      nameservers = lib.mkBefore ["100.100.100.100"]; # TODO: SOPS
      search = lib.mkBefore ["tuxedo-goanna.ts.net"]; # TODO: SOPS
    };

    services.tailscale = {
      enable = true;
      openFirewall = true;
      extraUpFlags = ["--ssh"];
    };
  };
}
# READ ME!
# ========
# Check these modules for additional options:
#   - ../networking/dns.nix
#   - ../security/firewall.nix

