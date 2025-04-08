{
  ...
}:
{
  mySystem = {
    # current-system-packages-list.nix :: /etc/current-system-packages-list
    current-system-packages-list.enable = true;

    # kernel.nix
    boot.kernelPackages = "xanmod_latest";
    myOptions.kernel.sysctl.netIpv4TcpCongestionControl = "westwood";

    # keyd.nix :: Keyboard remapping
    services.keyd.enable = true;
    myOptions.services.keyd.addKeydKeyboards = {
      TUXEDOInfinityBookPro14Gen6Standard = {
        ids = [ "0001:0001" ];
        settings = {
          main = {
            "capslock" = "capslock";
          };
          shift = {
            "capslock" = "insert";
          };
        };
      };
    };

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
    boot.plymouth = {
      enable = true;
      theme = "spinner";
    };

    # time.nix :: Timezone and time servers (NTP)
    networking.timeServers = [ "argentina" ];
    time.timeZone = "America/Buenos_Aires";

    # user.nix :: User management
    users.defaultUserShell = "zsh";
    users.users.doomguy = true; # Enable or disable the test account
  };
}
