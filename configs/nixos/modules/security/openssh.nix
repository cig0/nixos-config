{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem.services.openssh.enable;
in
{
  options.mySystem = {
    services.openssh = {
      enable = lib.mkEnableOption "Whether to enable the OpenSSH server";
      listenAddresses = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.listOf (
            lib.types.submodule {
              options = {
                addr = lib.mkOption { type = lib.types.str; };
                port = lib.mkOption { type = lib.types.port; };
              };
            }
          )
        );
        default = null;
        description = "List of addresses and ports for OpenSSH to listen on";
      };
    };
  };

  config = lib.mkIf cfg {
    services.openssh = {
      enable = true;
      openFirewall = true;
      listenAddresses = config.mySystem.services.openssh.listenAddresses;
    };

    # BUG_
    systemd.services = {
      sshd = lib.mkIf config.mySystem.services.tailscale.enable {
        after = [
          "tailscaled.service"
          # "wait-for-tailscale.service"
        ];
        # requires = [ "wait-for-tailscale.service" ]; # Hard dependency on the wait service
        # wants = [ "network-online.target" ]; # Ensures network-online.target is pulled in but not a hard dep.
      };

      # # Custom service to wait for Tailscale interface to be fully up
      # systemd.services.wait-for-tailscale = {
      #   description = "Wait for Tailscale interface to have an IP";
      #   after = [ "tailscaled.service" ];
      #   wantedBy = [ "sshd.service" ]; # Ties it to sshd startup
      #   before = [ "sshd.service" ]; # Ensures it runs before sshd
      #   serviceConfig = {
      #     Type = "oneshot";
      #     RemainAfterExit = "yes";
      #     ExecStart = ''
      #       ${pkgs.busybox}/bin/sh -c 'until ${pkgs.iproute2}/bin/ip addr show tailscale0 | ${pkgs.busybox}/bin/grep -q "inet "; do ${pkgs.busybox}/bin/sleep 1; ${pkgs.busybox}/bin/echo "Waiting for tailscale0..."; done'
      #     '';
      #     ExecStartPost = "${pkgs.busybox}/bin/echo 'Tailscale interface is up'";
      #     TimeoutSec = "45"; # Fails after 45s if tailscale0 never gets an IP
      #   };
      # };
    };
  };
}
