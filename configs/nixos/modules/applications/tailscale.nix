/*
  Check these modules for additional options:
    - ../networking/dns.nix
    - ../security/firewall.nix

  TODO: SOPS/age all sensible data
*/
{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "mySystem" "services" "tailscale" ] config;
in
{
  options.mySystem.services.tailscale.enable =
    lib.mkEnableOption "Whether to enable Tailscale client daemon.";

  config = lib.mkIf cfg.enable {
    networking = {
      firewall = {
        trustedInterfaces = [ "tailscale0" ];
      };
      search = [ "tuxedo-goanna.ts.net" ];
    };

    services = {
      tailscale = {
        enable = true;
        openFirewall = true;
        extraUpFlags = [ "--ssh" ];
      };
    };
  };
}
