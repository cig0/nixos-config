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
        trustedInterfaces = lib.mkBefore [ "tailscale0" ];
      };
      search = [ "tuxedo-goanna.ts.net" ];
    };

    services = {
      openssh = {
        listenAddresses = [
          { addr = "100.116.13.66"; } # A55
          { addr = "100.113.250.86"; } # desktop
          { addr = "100.107.5.119"; } # iPad
          { addr = "100.76.132.63"; } # perrrkele
        ];
        ports = [ 22 ];
      };
      tailscale = {
        enable = true;
        openFirewall = true;
        extraUpFlags = [ "--ssh" ];
      };
    };
  };
}
