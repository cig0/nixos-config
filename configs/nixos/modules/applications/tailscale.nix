/*
  Check these modules for additional options:
    - ../networking/dns.nix
    - ../security/firewall.nix
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
      search = [ "tuxedo-goanna.ts.net" ]; # TODO: SOPS/age
    };

    services = {
      openssh = {
        listenAddresses = [
          {
            addr = "0.0.0.0";
          }
        ];
      };
      tailscale = {
        enable = true;
        openFirewall = true;
        extraUpFlags = [ "--ssh" ];
      };
    };
  };
}
