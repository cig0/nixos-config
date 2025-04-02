{
  ...
}:
{
  mySystem = {
    # current-system-packages-list.nix :: /etc/current-system-packages-list
    current-system-packages-list.enable = true;

    # kernel.nix
    boot.kernelPackages = "stable";
    myOptions.kernel.sysctl.netIpv4TcpCongestionControl = "westwood";

    # keyd.nix :: Keyboard remapping
    services.keyd.enable = true;

    # maintenance.nix
    nix = {
      gc.automatic = false;
      settings.auto-optimise-store = true;
    };
    programs.nh = {
      enable = true;
      clean.enable = true;
    };
    system.autoUpgrade.enable = true;

    # nix-ld.nix
    programs.nix-ld.enable = true;

    # plymouth.nix
    boot.plymouth.enable = true;

    # time.nix :: Timezone and time servers (NTP)
    networking.timeServers = [ "argentina" ];
    time.timeZone = "America/Buenos_Aires";

    # user.nix :: User management
    users.defaultUserShell = "zsh";
    users.users.doomguy = true; # Enable or disable test account
  };
}
