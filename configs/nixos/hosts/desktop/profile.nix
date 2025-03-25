/*
  I’ll keep this idea on the back burner for now and revisit it later:

  Is it worth splitting this configuration module into modules under
  nixos/modules/common/profiles?

  Splitting may improve the handling of options management, but at the risk
  of obfuscating this host configuration.
*/
{
  ...
}:
{
  # NixOS host-specific options
  hardware.cpu.intel.updateMicrocode = true;

  services = {
    fwupd.enable = true;
    snap.enable = true; # nix-snapd
    zram-generator.enable = true;
  };

  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 5;
  };

  /*
    mySystem: Custom options defined in modules that override NixOS options.
    These allow setting default values without cluttering this configuration file,
    and makes it easy to follow what the options do if you already know them.
    Each module defines its own `mySystem` options.

    mySystem.myOptions: A layer of customized options for conveniently configuring
    various aspects of the host. Defined in `./nixos/modules/common/options`.
  */
  mySystem = {
    myOptions = {
      environment.variables.gh.username = "cig0";
      hardware = {
        cpu = "intel";
        gpu = "nvidia";
      };
      kernel.sysctl.netIpv4TcpCongestionControl = "westwood"; # Optimized for wireless networks
      nixos.flake.path = "/home/cig0/workdir/cig0/nixos-config";
    };

    # Applications
    programs.appimage.enable = true;
    programs.firefox.enable = true;
    services.flatpak.enable = true;
    programs.git = {
      enable = true;
      lfs.enable = true;
    };
    # programs.krew.enable = false; # WIP
    programs.lazygit.enable = true;
    programs.nixvim.enable = true;
    services.ollama = {
      enable = false;
      acceleration = null;
    };
    services.open-webui.enable = false;
    services.tailscale.enable = true;
    package.yazi.enable = true;
    programs.yazi.enable = false;
    programs.zsh.enable = true; # If disabled, this option is automatically enabled when users.defaultUserShell="zsh"
    packages = {
      baseline = true;
      cli._all = true;
      gui = true;
      guiShell.kde = true;
    };

    # GUI shell - KDE Plasma
    programs.kde-pim.enable = false;
    programs.kdeconnect.enable = true;
    services.displayManager = {
      ly.enable = false;
      sddm.enable = true;
    };
    services.desktopManager.plasma6.enable = true;
    xdg.portal.enable = true;

    # Hardware
    hardware = {
      graphics.enable = true;
      nvidia-container-toolkit.enable = true;
    };

    # Home Manager
    home-manager.enable = true;

    # Networking
    programs.mtr.enable = true;
    networking.nameservers = true;
    networking.nftables.enable = true;
    services.resolved.enable = true;
    networking.stevenblack.enable = true;
    systemd.services.stevenblack-unblock.enable = true;
    # Networking - NetworkManager
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    # Power Management
    programs.auto-cpufreq.enable = false;
    powerManagement.enable = true;
    services.thermald.enable = true;

    # Radio
    hardware.bluetooth.enable = true;

    # Security
    programs.gnupg.enable = true;
    boot.lanzaboote.enable = false;
    services.openssh.enable = true;
    # Security - Firewall
    networking.firewall = {
      enable = true;
      allowPing = false;
    };
    # Security - Sudo
    security.sudo = {
      enable = true;
      extraConfig = ''
        Defaults passwd_timeout=1440, timestamp_timeout=1440
      ''; # From a security perspective, it isn't a good idea to extend the sudo *_timeout (let alone doing so on a server!). I set this on my personal laptop and desktop for convenience.
    };

    # System
    current-system-packages-list.enable = true;
    programs.nix-ld.enable = true;
    # System - Audio
    audio-subsystem.enable = true;
    services.speechd.enable = true;
    # System - Kernel
    boot.kernelPackages = "stable";
    # System - Keyboard
    services.keyd.enable = false;
    # System - Maintenance
    nix = {
      gc.automatic = false;
      settings.auto-optimise-store = true;
    };
    programs.nh = {
      enable = true;
      clean.enable = true;
    };
    system.autoUpgrade.enable = true;
    # System - Time
    networking.timeServers = [ "argentina" ];
    time.timeZone = "America/Buenos_Aires";
    # System - User management
    users.defaultUserShell = "zsh";
    users.users.doomguy = true; # Enable or disable test account

    # Virtualisation
    virtualisation = {
      incus.enable = true;
      libvirtd.enable = true;
      podman.enable = true;
    };
  };
}
