/*
  Check these modules for additional options:
    - ../networking/dns.nix
    - ../security/firewall.nix
*/
{
  config,
  lib,
  pkgs,
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
        # authKeyFile = ../../../../ts;
        openFirewall = true;
        extraUpFlags = [ "--ssh" ];
      };
      tailscaleAuth = {
        enable = false;
        group = "users";
        user = "cig0";
      };
    };

    # BUG_
    /*
      systemd.services.tailscale-auth = {
        description = "Authenticate Tailscale";
        after = [ "tailscaled.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.tailscale}/bin/tailscale up --authkey=${config.services.tailscale.authKeyFile}";
        };
      };

      systemd.services.tailscaled = {
        after = [ "network-online.target" ];
        before = [ "sshd.service" ]; # Ensures it runs before sshd
        wants = [ "network-online.target" ];
      };
    */
  };
}
