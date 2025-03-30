{
  ...
}:
{
  mySystem = {
    current-system-packages-list.enable = true;
    programs.nix-ld.enable = true;

    # Audio
    audio-subsystem.enable = true;
    services.speechd.enable = true;

    # Kernel
    boot.kernelPackages = "stable";
    boot.plymouth.enable = true;

    # Keyboard
    services.keyd.enable = false;

    # Maintenance
    nix = {
      gc.automatic = false;
      settings.auto-optimise-store = true;
    };
    programs.nh = {
      enable = true;
      clean.enable = true;
    };
    system.autoUpgrade.enable = true;

    # Time
    networking.timeServers = [ "argentina" ];
    time.timeZone = "America/Buenos_Aires";

    # User management
    users.defaultUserShell = "zsh";
    users.users.doomguy = true; # Enable or disable test account
  };
}
