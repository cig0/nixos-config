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
{
  options.mySystem.services.tailscale.enable =
    lib.mkEnableOption "Whether to enable Tailscale client daemon.";

  config = lib.mkIf config.mySystem.services.tailscale.enable {
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
