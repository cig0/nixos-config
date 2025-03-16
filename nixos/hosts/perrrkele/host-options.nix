# TODO: Consider splitting into modules under nixos/profiles (../../profiles)
# Splitting may improve options management but risks obfuscating the host config.
{
  config,
  ...
}:
{
  # ░░░░░░░█▀█░█▀▀░█▀▄░█▀▄░█▀▄░█░█░█▀▀░█░░░█▀▀░▀░█▀▀░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
  # ░░░░░░░█▀▀░█▀▀░█▀▄░█▀▄░█▀▄░█▀▄░█▀▀░█░░░█▀▀░░░▀▀█░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
  # ░░░░░░░▀░░░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░▀▀▀░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░
  # For Home Manager options, check home-manager/home.nix

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
    memoryPercent = 15;
  };

  # mySystem: Personalized options from modules that shadows NixOS' options to set default values without polluting this host configuration file. Defined in each module.
  # mySystem.myOptions: a customized options layer to conviniently customize different aspects of the host. Defined in ./nixos/modules/common/options.

  mySystem = {
    myOptions = {
      hardware = {
        cpu = "intel";
        gpu = "intel";
      };

      nixos = {
        # Channel abstraction handled via `channelPkgs` for stable (`pkgs`) or unstable (`pkgsUnstable`) selection
        # See hardware-acceleration.nix for an example
        # Defined in: nixos/modules/common/options/nixos.nix
        channelPkgs = "pkgs";
      };
    };

    # Applications
    programs.appimage.enable = true;
    programs.firefox.enable = true;
    services.flatpak.enable = true;
    programs.git = {
      enable = true;
      lfs.enable = true;
    };

    programs.krew.enable = false; # WIP
    programs.lazygit.enable = true;
    programs.nixvim.enable = true;

    services.ollama = {
      enable = false;
      acceleration = null;
    };

    services.tailscale.enable = true;
    package.yazi.enable = true;
    programs.yazi.enable = false;
    programs.zsh.enable = true;

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
    programs.auto-cpufreq.enable = true;
    powerManagement.enable = true;
    services.thermald.enable = true;

    # Radio
    hardware.bluetooth.enable = true;

    # Security
    programs.gnupg.enable = true;
    boot.lanzaboote.enable = true;
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
    boot.kernelPackages = "xanmod_latest";
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
    users.users.doomguy = true; # Enable or disable test account

    # Virtualisation
    virtualisation = {
      incus.enable = true;
      libvirtd.enable = true;
      podman.enable = true;
    };
  };
}
