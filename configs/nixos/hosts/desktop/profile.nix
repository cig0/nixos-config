/*
  Idea for the back burner:

  Is it worth splitting this configuration module into modules under
  nixos/modules/common/profiles after a separation of concerns pattern?

  Splitting may improve the handling of options management, but at the risk
  of obfuscating this host configuration.

  Also, while many options do repeat themselves between hosts, each host is
  different.
  I imagine this profile configuration module showing a handful of host-specific
  options with the rest of the configuration imported dynamically from the profile
  modules (which isn't bad), but at the same time that approach will hide the rest
  of the host configuration... 🤨
*/
{
  config,
  lib,
  self,
  ...
}:
{
  # NixOS host-specific options
  hardware.cpu.intel.updateMicrocode = true;

  services = {
    fwupd.enable = true;

    # Security
    openssh = {
      listenAddresses = builtins.concatLists [
        # WLAN address; I'm wrapping it in a singleton list
        (lib.singleton { addr = "192.168.0.0"; })

        # Tailscale
        (lib.optionals (config.networking.hostName == "desktop") [ { addr = "100.113.250.86"; } ])
        (lib.optionals (config.networking.hostName == "perrrkele") [ { addr = "100.76.132.63"; } ])
      ];
      ports = [ 22 ];
    };

    snap.enable = true; # nix-snapd
    zram-generator.enable = true;
  };

  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 5;
  };

  /*
    mySystem options: Custom options defined in modules that override NixOS options.
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

      /*
        nixos.flake.path:

        Ensure the directory is writable!
        Setting this option to `self.outPath` is the shortest way to get locked out from your own
        system.
      */
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
    programs.tmux.enable = true;
    package.yazi.enable = true;
    programs.yazi.enable = false;
    programs.zsh.enable = true; # If disabled, this option is automatically enabled when users.defaultUserShell="zsh" is set
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
      allowedTCPPorts = [ ];
    };
    # Security - Sudo
    security.sudo = {
      enable = true;

      /*
        passwd_timeout=1440, timestamp_timeout=1440:
        Extending sudo timeout this much is generally unsafe, especially on servers!
        I only enable this setting on personal devices for convenience.
      */
      extraConfig = ''
        Defaults passwd_timeout=1440, timestamp_timeout=1440
      '';
    };

    # System
    current-system-packages-list.enable = true;
    programs.nix-ld.enable = true;
    # System - Audio
    audio-subsystem.enable = true;
    services.speechd.enable = true;
    # System - Kernel
    boot.kernelPackages = "stable";
    boot.plymouth.enable = true;
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
