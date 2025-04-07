{
  config,
  ...
}:
{
  /*
    ═══════════════════════════════
    Applications
    ═══════════════════════════════
  */
  mySystem.programs.appimage.enable = true; # appimage.nix
  mySystem.services.displayManager = {
    # display-manager.nix
    ly.enable = false;
    sddm.enable = true;
  };
  mySystem.programs.firefox.enable = true; # firefox.nix
  mySystem.programs.git = {
    # git.nix
    enable = true;
    lfs.enable = true;
  };
  mySystem.programs.kde-pim.enable = false; # kde.nix
  mySystem.programs.kdeconnect.enable = true; # kde.nix
  mySystem.services.desktopManager.plasma6.enable = true; # kde.nix
  mySystem.programs.lazygit.enable = true; # lazygit.nix
  mySystem.programs.mtr.enable = true; # mtr.nix
  mySystem.services.flatpak.enable = true; # nix-flatpak.nix
  mySystem.programs.nixvim.enable = true; # nixvim.nix
  mySystem.services.ollama = {
    # ollama.nix
    enable = false;
    acceleration = null;
  };
  mySystem.services.open-webui = {
    # open-webui.nix
    enable = false;
    # port = 3000; # Default port
  };
  mySystem.packages = {
    # packages.nix
    baseline = true;
    cli._all = true;
    gui = true;
    guiShell.kde = true;
  };
  services.snap.enable = true; # nix-snapd (from flake)
  mySystem.programs.tmux = {
    # tmux.nix
    enable = true;
    extraConfig = "set -g status-style bg=colour53,fg=white";
  };
  mySystem.package.yazi.enable = true; # yazi.nix
  mySystem.programs.yazi.enable = false; # yazi.nix
  mySystem.programs.zsh.enable = true; # zsh.nix. If disabled, this option is automatically enabled when `users.defaultUserShell` is set to "zsh".
  mySystem.xdg.portal.enable = true; # xdg-portal.nix

  /*
    ═══════════════════════════════
    Audio
    ═══════════════════════════════
  */
  mySystem.audio-subsystem.enable = true;
  mySystem.services.speechd.enable = true;

  /*
    ═══════════════════════════════
    Common
    ═══════════════════════════════
  */
  mySystem.myOptions.nixos.flakePath = "/home/cig0/workdir/cig0/nixos-config"; # nixos.nix

  /*
    ═══════════════════════════════
    Hardware
    ═══════════════════════════════
  */
  mySystem.hardware = {
    bluetooth.enable = true; # bluetooth.nix
    graphics.enable = true; # graphics-acceleration.nix
    nvidia-container-toolkit.enable = true;
  };
  mySystem.myOptions.hardware = {
    # cpu-gpu.nix
    cpu = "intel";
    gpu = "nvidia";
  };
  hardware.cpu.${config.mySystem.myOptions.hardware.cpu}.updateMicrocode = true;
  services = {
    fwupd.enable = true;
    zram-generator.enable = true;
  };
  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 15;
  };

  /*
    ═══════════════════════════════
    Home Manager
    Make sure your system user and shell environment is properly configured
    before disabling this option!
    ═══════════════════════════════
  */
  mySystem.home-manager.enable = true;

  /*
    ═══════════════════════════════
    Networking
    ═══════════════════════════════
  */
  mySystem.networking.nameservers = true; # nameservers.nix
  mySystem.networking.nftables.enable = true; # nftables.nix
  mySystem.networking.networkmanager = {
    # network-manager/network-manager.nix
    enable = true;
    dns = "systemd-resolved";
  };
  mySystem.services.resolved.enable = true; # resolved.nix
  mySystem.networking.stevenblack = {
    # stevenblack.nix
    enable = true;
    block = [
      "gambling"
      "porn"
      "social"
    ];
  };
  mySystem.systemd.services.stevenblack-unblock.enable = true; # stevenblack.nix
  mySystem.services.tailscale.enable = true; # tailscale.nix
  mySystem.myOptions.services.tailscale.ip = "100.113.250.86"; # tailscale.nix

  /*
    ═══════════════════════════════
    Power Management
    ═══════════════════════════════
  */
  mySystem.powerManagement.enable = true; # power-management.nix
  mySystem.services.thermald.enable = true; # thermald.nix

  /*
    ═══════════════════════════════
    Security
    ═══════════════════════════════
  */
  mySystem.networking.firewall = {
    # firewall.nix
    enable = true;
    allowPing = false;
    allowedTCPPorts = [
      22
      3000
      8080
      8443
    ];
  };
  mySystem.programs.gnupg.enable = true; # gnupg.nix
  mySystem.boot.lanzaboote.enable = true; # lanzaboote.nix
  mySystem.services.openssh = {
    # opensshd.nix
    enable = true;
    listenAddresses = [
      {
        # localhost
        addr = "127.0.0.1";
        port = 22;
      }
      {
        # WLAN IP address
        addr = "192.168.0.246";
        port = 22;
      }
      {
        # Tailscale's IP address
        addr = "${config.mySystem.myOptions.services.tailscale.ip}";
        port = config.mySystem.myOptions.services.tailscale.openssh.port;
      }
    ];
  };
  mySystem.security.sudo = {
    # sudo.nix
    enable = true;
    extraConfig = ''
      Defaults passwd_timeout=1440, timestamp_timeout=1440
    '';
    /*
      passwd_timeout=1440, timestamp_timeout=1440:
      Extending sudo timeout this much is generally unsafe, especially on servers!
      I only enable this setting on personal devices for convenience.
    */
  };

  /*
    ═══════════════════════════════
    System
    ═══════════════════════════════
  */
  mySystem.current-system-packages-list.enable = true; # current-system-packages-list.nix
  mySystem.boot.kernelPackages = "stable"; # kernel.nix
  mySystem.myOptions.kernel.sysctl.netIpv4TcpCongestionControl = "westwood"; # kernel.nix
  mySystem.services.keyd.enable = true; # keyd.nix
  mySystem.nix = {
    # maintenance.nix
    gc.automatic = false;
    settings.auto-optimise-store = true;
  };
  mySystem.programs.nh = {
    # maintenance.nix
    enable = true;
    clean.enable = true;
  };
  mySystem.system.autoUpgrade.enable = true; # maintenance.nix
  mySystem.programs.nix-ld.enable = true; # nix-ld.nix
  mySystem.boot.plymouth = {
    # plymouth.nix
    enable = true;
    theme = "spinner";
  };
  mySystem.networking.timeServers = [ "argentina" ]; # time.nix
  mySystem.time.timeZone = "America/Buenos_Aires"; # time.nix
  mySystem.users = {
    # user.nix
    defaultUserShell = "zsh";
    users.doomguy = true; # Enable or disable test account
  };

  /*
    ═══════════════════════════════
    Virtualisation
    ═══════════════════════════════
  */
  mySystem.virtualisation = {
    incus.enable = true; # incus.nix
    libvirtd.enable = true; # libvirt.nix
    podman.enable = true; # containerisation.nix
  };
}
