{
  ...
}:
{
  mySystem = {
    programs.mtr.enable = true;
    networking.nameservers = true;
    networking.nftables.enable = true;
    services.resolved.enable = true;
    networking.stevenblack.enable = true;
    systemd.services.stevenblack-unblock.enable = true;

    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    myOptions = {
      /*
        westwood: Optimized for wireless networks.
        For more details, see the module kernel.nix.
      */
      kernel.sysctl.netIpv4TcpCongestionControl = "westwood";
    };
  };
}
