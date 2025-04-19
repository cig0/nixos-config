/*
  TODO: define settings per Trusted Interface, not globally
  https://github.com/users/cig0/projects/1/views/6?pane=issue&itemId=104610250&issue=cig0%7Cnixos-config%7C29
*/
{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixos.networking;
in
{
  options.myNixos.networking = {
    firewall = {
      enable = lib.mkEnableOption ''
        Whether to enable the firewall. This is a simple stateful
        firewall that blocks connection attempts to unauthorised TCP
        or UDP ports on this machine.'';

      allowPing = lib.mkEnableOption ''
        Whether to respond to incoming ICMPv4 echo requests
        (\"pings\").  ICMPv6 pings are always allowed because the
        larger address space of IPv6 makes network scanning much
        less effective.'';

      allowedTCPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.int;
        default = [ ];
        description = "List of TCP ports to allow incoming connections to.";
      };
    };
  };

  config = lib.mkIf config.networking.firewall.enable {
    networking = {
      firewall = {
        trustedInterfaces = [
          "lo"
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
  };
}
