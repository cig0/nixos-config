let
  commonSettings = {
    # Applications
    mySystem.packages.baseline = true;
    mySystem.packages.cli.backup = true;
    mySystem.packages.cli.security = true;
    mySystem.packages.cli.vcs = true;
    mySystem.programs.git.enable = true;
    mySystem.programs.nh.enable = true;
    mySystem.programs.nixvim.enable = true;
    mySystem.services.tailscale.enable = true;
    mySystem.programs.zsh.enable = true;

    # Networking
    mySystem.programs.mtr.enable = true;
    mySystem.networking.nameservers = true;
    mySystem.networking.nftables.enable = true;
    mySystem.services.resolved.enable = true;
    mySystem.networking.stevenblack.enable = true;
    mySystem.systemd.services.stevenblack-unblock.enable = true;

    # Power Management
    mySystem.services.thermald.enable = true;

    # Security
    mySystem.programs.gnupg.enable = true;
    mySystem.boot.lanzaboote.enable = true;
    mySystem.services.openssh.enable = true;
    mySystem.security.sudo.enable = true;
    # Security - Firewall
    mySystem.networking.firewall.enable = true;
    mySystem.networking.firewall.allowPing = false;

    # System
    mySystem.current-system-packages-list.enable = true;
    mySystem.services.fwupd.enable = true;
    # System - Kernel
    mySystem.boot.kernelPackages = "stable";
    # System - Maintenance
    mySystem.nix.settings.auto-optimise-store = true;
    mySystem.nix.gc.automatic = true;
    mySystem.system.autoUpgrade.enable = true;

    # Virtualisation
    mySystem.virtualisation.podman.enable = true;
  };
in
  commonSettings
