{
  ...
}:
{
  mySystem = {
    programs.mtr.enable = true;
    networking.nameservers = true;
    networking.nftables.enable = true;
    services.resolved.enable = true;
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    networking.stevenblack = {
      enable = true;
      block = [
        "gambling"
        "porn"
        "social"
      ];
    };
    systemd.services.stevenblack-unblock.enable = true;

    myOptions = {
      /*
        westwood: Optimized for wireless networks.
        For more details, see the module kernel.nix.
      */
      kernel.sysctl.netIpv4TcpCongestionControl = "westwood";

      services.tailscale.ip = "100.76.132.63";
    };
  };
}
