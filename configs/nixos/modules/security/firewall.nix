# TODO: https://github.com/users/cig0/projects/1/views/6?pane=issue&itemId=103540326&issue=cig0%7Cnixos-config%7C16
{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "mySystem" "networking" "firewall" ] config;
in
{
  options.mySystem.networking.firewall = {
    enable = lib.mkEnableOption "Whether to enable the firewall. This is a simple stateful
firewall that blocks connection attempts to unauthorised TCP
or UDP ports on this machine.";
    allowPing = lib.mkEnableOption "Whether to respond to incoming ICMPv4 echo requests
(\"pings\").  ICMPv6 pings are always allowed because the
larger address space of IPv6 makes network scanning much
less effective.";
    allowedTCPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ ];
      description = "List of TCP ports to allow incoming connections to.";
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      firewall = {
        enable = true;
        allowPing = cfg.allowPing;
        allowedTCPPorts = [ 22 ];
        allowedTCPPortRanges = [ ];
        allowedUDPPorts = [ ];
        allowedUDPPortRanges = [ ];
        trustedInterfaces = [
          "tailscale0"
          "virbr0"
        ];
        checkReversePath = "loose";
        /*
          The networking.firewall.checkReversePath option in NixOS controls whether the Linux kernel's
          reverse path filtering mechanism should be enabled or not, which can enhance security by
          preventing IP spoofing attacks but may also cause issues in certain network configurations.
        */
      };
    };

    services = {
      open-webui = {
        port = config.mySystem.services.open-webui.port;
        openFirewall = config.mySystem.services.open-webui.openFirewall;
      };

      /*
        KDE Connect:
        Ports: 1714 to 1764 TCP/UDP
        Module: ../applications/kde/kdeconnect.nix

        OpenSSH server:
        Ports: 22
        Module: ../security/openssh.nix

        Syncthing:
        Ports: 22000/TCP 21027,22000/UDP
        Module: ../applications/syncthing.

        Tailscale:
        Ports:
        Module: ../networking/tailscale.nix
      */
    };
  };
}
