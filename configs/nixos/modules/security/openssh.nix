{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myNixos = {
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

  config = lib.mkIf config.services.openssh.enable {
    services.openssh = {
      openFirewall = true;
      # listenAddresses = config.myNixos.services.openssh.listenAddresses;
      # startWhenNeeded = true; # Enable socket activation
    };

    systemd.services = {
      sshd = lib.mkIf config.myNixos.services.tailscale.enable {
        /*
           HACK: Add an ExecStartPre to ensure Tailscale interface is ready.

          I absolutely hate that this is the only way I've found to force `sshd.service` to wait for
          `tailscaled.service` to create the network interface and assign the IP address (othwerwise
          fails).
        */
        serviceConfig.ExecStartPre = [
          "${pkgs.bash}/bin/bash -c 'until ${pkgs.iproute2}/bin/ip addr show dev tailscale0 | ${pkgs.gnugrep}/bin/grep -q \"${config.myNixos.myOptions.services.tailscale.ip}\"; do sleep 1; done'"
        ];

        bindsTo = [
          "nm-file-secret-agent.service"
          "tailscaled.service"
        ];
      };
    };

    /*
      FIXME: I'm leaving this option here to revisit this approach in the future
      Remember to enable `startWhenNeeded`.

      systemd.sockets.sshd = lib.mkIf config.myNixos.ervices.tailscale.enable {
        # This ensures the socket will correctly bind once the interface is available
        bindsTo = [ "sys-subsystem-net-devices-tailscale0.device" ];
        after = [
          # "network-online.target"
          "sys-subsystem-net-devices-tailscale0.device"
        ];
      };
    */
  };
}
