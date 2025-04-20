{
  config,
  inputs,
  myArgs,
  ...
}:
{
  /*
    ═══════════════════════════════
    Applications
    ═══════════════════════════════
  */
  # AI & Machine Learning
  myNixos.services.ollama = {
    # ollama.nix
    enable = false;
    acceleration = null;
  };
  myNixos.services.open-webui = {
    # open-webui.nix
    enable = false;
    # port = 3000; # Default port
  };

  # Core Applications
  myNixos.programs.appimage.enable = true; # appimage.nix
  myHm.programs.atuin.enable = true; # common/myhm/default.nix
  myNixos.programs.firefox.enable = true; # firefox.nix
  myNixos.programs.mtr.enable = true; # mtr.nix
  myNixos.services.flatpak.enable = true; # nix-flatpak.nix
  services.snap.enable = true; # nix-snapd (from flake)

  # Display Manager
  myNixos.services.displayManager = {
    # display-manager.nix
    ly.enable = false;
    sddm.enable = true;
  };

  # File Synchronization
  myNixos = {
    myOptions = {
      services.syncthing.guiAddress.port = config.mySecrets.getSecret "shared.myNixos.myOptions.services.syncthing.guiAddress.port";
    }; # syncthing.nix
  };
  services.syncthing = {
    enable = true;
  }; # syncthing.nix

  # KDE Desktop Environment
  myNixos.programs.kde-pim.enable = false; # kde.nix
  myNixos.programs.kdeconnect.enable = true; # kde.nix
  myNixos.services.desktopManager.plasma6.enable = true; # kde.nix
  myNixos.xdg.portal.enable = true; # xdg-portal.nix

  # Package Collections
  myNixos.packages = {
    # packages.nix
    baseline = true;
    cli._all = true;
    gui = true;
    guiShell.kde = true;
  };

  # Text Editors & Terminal Tools
  myNixos.programs.nixvim.enable = true; # nixvim.nix
  myNixos.programs.tmux = {
    # tmux.nix
    enable = true;
    extraConfig = "set -g status-style bg=colour26,fg=white";
  };
  myNixos.package.yazi.enable = true; # yazi.nix
  myNixos.programs.yazi.enable = false; # yazi.nix
  myNixos.programs.zsh.enable = true; # zsh.nix. If disabled, this option is automatically enabled when `users.defaultUserShell` is set to "zsh".

  # VCS
  myHm.programs.git = {
    # common/options/myHm/default.nix
    enable = true;
    lfs.enable = true;
  };
  myNixos.programs.lazygit.enable = true; # lazygit.nix

  /*
    ═══════════════════════════════
    Audio
    ═══════════════════════════════
  */
  myNixos.audio-subsystem.enable = true;
  myNixos.services.speechd.enable = true;

  /*
    ═══════════════════════════════
    Common
    ═══════════════════════════════
  */
  myNixos.myOptions.flakeSrcPath = "/home/cig0/workdir/cig0/nixos-config"; # common/options/myoptions.nix

  /*
    ═══════════════════════════════
    Hardware
    ═══════════════════════════════
  */
  # CPU & Firmware
  hardware.cpu.${config.myNixos.myOptions.hardware.cpu}.updateMicrocode = true;
  services.fwupd.enable = true;

  # GPU, Graphics & Display
  myNixos.hardware = {
    bluetooth.enable = true; # bluetooth.nix
    graphics.enable = true; # options.nix, intel.nix
  };
  myNixos.myOptions.hardware = {
    # options.nix
    cpu = "intel";
    gpu = "intel";
  };

  # Swap Memory
  services.zram-generator.enable = true;
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
  myNixos.home-manager.enable = true;

  /*
    ═══════════════════════════════
    Networking
    ═══════════════════════════════
  */
  # DNS & Network Management
  myNixos.networking.nameservers = true; # nameservers.nix
  myNixos.networking.networkmanager = {
    # network-manager/network-manager.nix
    enable = true;
    dns = "systemd-resolved";
  };
  myNixos.services.resolved.enable = true; # resolved.nix
  myNixos.networking.stevenblack = {
    # stevenblack.nix
    enable = true;
    block = [
      "gambling"
      "porn"
      "social"
    ];
  };
  myNixos.systemd.services.stevenblack-unblock.enable = true; # stevenblack.nix

  # Firewall & Security
  myNixos.networking.nftables.enable = true; # nftables.nix

  # VPN & Remote Access
  myNixos.services.tailscale.enable = true; # tailscale.nix
  myNixos.myOptions.services.tailscale = {
    ip = config.mySecrets.getSecret "host.myNixos.myOptions.services.tailscale.ip"; # tailscale.nix
    tailnetName = config.mySecrets.getSecret "host.myNixos.myOptions.services.tailscale.tailnetName"; # tailscale.nix
  };

  /*
    ═══════════════════════════════
    Power Management
    ═══════════════════════════════
  */
  myNixos.programs.auto-cpufreq.enable = true; # auto-cpufreq.nix
  myNixos.powerManagement.enable = true; # power-management.nix
  myNixos.services.thermald.enable = true; # thermald.nix
  services.tlp.enable = false; # Disabled, as I'm using auto-cpufreq

  /*
    ═══════════════════════════════
    Secrets
    ═══════════════════════════════
  */
  mySecrets.secretsFile = {
    host = "secrets/hosts/${myArgs.system.hostname}/secrets.json";
    shared = "secrets/shared/secrets.json";
  };

  /*
    ═══════════════════════════════
    Security
    ═══════════════════════════════
  */
  # Authentication & Access Control
  myNixos.security.sudo = {
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

  # Encryption & Keys
  myNixos.programs.gnupg.enable = true; # gnupg.nix
  myNixos.programs.gnupg.enableSSHSupport = false; # gnupg.nix. myNixos.programs.gnupg must be enabled.
  myNixos.programs.ssh.startAgent = true; # ssh.nix

  # Firewall
  networking.firewall = {
    # firewall.nix
    enable = true;
    allowPing = false;
    allowedTCPPorts = config.mySecrets.getSecret "host.networking.firewall.allowedTCPPorts";
  };

  # Secure Boot
  myNixos.boot.lanzaboote.enable = true; # lanzaboote.nix

  # SSH Server
  services.openssh = {
    # opensshd.nix
    enable = true;
    listenAddresses = [
      {
        # localhost
        addr = "127.0.0.1";
        port = config.mySecrets.getSecret "host.services.openssh.listenAddresses.localhostPort";
      }
      {
        /*
          TODO: Make this a dynamic option, it has to work only with trusted networks.
          That way I won't need to uncomment this address when connecting from an untrusted network.
        */
        # wlo1
        addr = config.mySecrets.getSecret "host.services.openssh.listenAddresses.wlo1Address";
        port = config.mySecrets.getSecret "host.services.openssh.listenAddresses.wlo1Port";
      }
      {
        # Tailscale's IP address
        addr = "${config.myNixos.myOptions.services.tailscale.ip}";
        port = config.myNixos.myOptions.services.tailscale.openssh.port;
      }
    ];
  };

  /*
    ═══════════════════════════════
    System
    ═══════════════════════════════
  */
  # Boot & Kernel
  myNixos.boot.kernelPackages = "stable"; # kernel.nix
  myNixos.myOptions.kernel.sysctl.netIpv4TcpCongestionControl = "westwood"; # kernel.nix
  myNixos.boot.plymouth = {
    # plymouth.nix
    enable = false;
    theme = "evil-nixos";
  };

  # Input Devices
  myNixos.services.keyd.enable = true; # keyd.nix

  # Maintenance & Updates
  myNixos.current-system-packages-list.enable = true; # current-system-packages-list.nix
  myNixos.nix = {
    # maintenance.nix
    gc.automatic = false;
    settings.auto-optimise-store = true;
  };
  myNixos.programs.nh = {
    # maintenance.nix
    enable = true;
    clean.enable = true;
  };
  myNixos.system.autoUpgrade.enable = true; # maintenance.nix

  # Nix Environment
  myNixos.programs.nix-ld.enable = true; # nix-ld.nix

  # Time & Locale
  myNixos.networking.timeServers = [ "argentina" ]; # time.nix
  myNixos.time.timeZone = "America/Buenos_Aires"; # time.nix

  # Users
  myNixos.users = {
    # user.nix
    defaultUserShell = "zsh";
    users.doomguy = true; # Enable or disable the test account
  };

  /*
    ═══════════════════════════════
    Virtualisation
    ═══════════════════════════════
  */
  myNixos.virtualisation = {
    incus.enable = true; # incus.nix
    libvirtd.enable = true; # libvirt.nix
    podman.enable = true; # containerisation.nix
  };
}
