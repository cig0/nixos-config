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
      openssh = {
        listenAddresses = builtins.concatLists [
          (lib.optionals (config.networking.hostName == "desktop") [ { addr = "100.113.250.86"; } ])
          (lib.optionals (config.networking.hostName == "perrrkele") [ { addr = "100.76.132.63"; } ])
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
