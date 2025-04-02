{
  ...
}:
{
  mySystem = {
    # nameservers.nix
    networking.nameservers = true;

    # nftables.nix
    networking.nftables.enable = true;

    # network-manager/network-manager.nix
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    # resolved.nix
    services.resolved.enable = true;

    # stevenblack.nix :: Steven Black Hosts File Blacklist
    networking.stevenblack = {
      enable = true;
      block = [
        "gambling"
        "porn"
        "social"
      ];
    };
    systemd.services.stevenblack-unblock.enable = true;

    # tailscale.nix :: Tailscale IP
    myOptions.services.tailscale.ip = "100.76.132.63";
  };
}
