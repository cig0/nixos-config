{ config, lib, ... }:

let
  cfg = config.mySystem.networking.firewall;

in {
  options.mySystem.networking.firewall = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable and manage firewall";
  };

  config = lib.mkIf (cfg == "true") {
    networking = {
      firewall = {
        enable = true;
        allowPing = false;
        allowedTCPPorts = [];
        allowedTCPPortRanges = [];
        allowedUDPPorts = [];
        allowedUDPPortRanges = [];
        trustedInterfaces = [ "tailscale0" "virbr0" ];  # TODO: allow Tailscale to add itself to trustedInterfaces (from its own module)
        checkReversePath = "loose";
        # The networking.firewall.checkReversePath option in NixOS controls whether the Linux kernel's
        # reverse path filtering mechanism should be enabled or not, which can enhance security by
        # preventing IP spoofing attacks but may also cause issues in certain network configurations.
      };
    };

    services = {
      # KDE Connect:
        # Ports: 1714 to 1764 TCP/UDP
        # Module: ../applications/kde/kdeconnect.nix

      # OpenSSH server:
        # Ports: 22, 22222 (for Tailscale)
        # Module: ../security/openssh.nix

      # Syncthing:
        # Ports: 22000/TCP 21027,22000/UDP
        # Module: ../applications/syncthing.nix

      # Tailscale:
        # Ports:
        # Module: ../networking/tailscale.nix
    };
  };
}