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
  myNixos.programs.appimage.enable = true; # appimage.nix
  myNixos.services.displayManager = {
    # display-manager.nix
    ly.enable = false;
    sddm.enable = true;
  };
  myNixos.programs.firefox.enable = true; # firefox.nix
  myHm.programs.git = {
    # common/options/myHm/default.nix
    enable = true;
    lfs.enable = true;
  };
  myNixos.programs.kde-pim.enable = false; # kde.nix
  myNixos.programs.kdeconnect.enable = true; # kde.nix
  myNixos.services.desktopManager.plasma6.enable = true; # kde.nix
  myNixos.programs.lazygit.enable = true; # lazygit.nix
  myNixos.programs.mtr.enable = true; # mtr.nix
  myNixos.services.flatpak.enable = true; # nix-flatpak.nix
  myNixos.programs.nixvim.enable = true; # nixvim.nix
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
  myNixos.packages = {
    # packages.nix
    baseline = true;
    cli._all = true;
    gui = true;
    guiShell.kde = true;
  };
  services.snap.enable = true; # nix-snapd (from flake)
  myNixos.programs.tmux = {
    # tmux.nix
    enable = true;
    extraConfig = "set -g status-style bg=colour26,fg=white";
  };
  myNixos.package.yazi.enable = true; # yazi.nix
  myNixos.programs.yazi.enable = false; # yazi.nix
  myNixos.programs.zsh.enable = true; # zsh.nix. If disabled, this option is automatically enabled when `users.defaultUserShell` is set to "zsh".
  myNixos.xdg.portal.enable = true; # xdg-portal.nix

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
  myNixos.myOptions.flakePath = "/home/cig0/workdir/cig0/nixos-config"; # common/options/myoptions.nix

  /*
    ═══════════════════════════════
    Hardware
    ═══════════════════════════════
  */
  myNixos.hardware = {
    bluetooth.enable = true; # bluetooth.nix
    graphics.enable = true; # options.nix, intel.nix, nvidia.nix
  };
  myNixos.myOptions.hardware = {
    # options.nix
    cpu = "intel";
    gpu = "intel";
  };
  hardware.cpu.${config.myNixos.myOptions.hardware.cpu}.updateMicrocode = true;
  services = {
    fwupd.enable = true;
    zram-generator.enable = true;
  };
  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 5;
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
  myNixos.networking.nameservers = true; # nameservers.nix
  myNixos.networking.nftables.enable = true; # nftables.nix
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
  myNixos.services.tailscale.enable = true; # tailscale.nix
  myNixos.myOptions.services.tailscale.ip = "100.95.128.128"; # tailscale.nix

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
    Security
    ═══════════════════════════════
  */
  myNixos.networking.firewall = {
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
  myNixos.programs.gnupg.enable = true; # gnupg.nix
  myNixos.boot.lanzaboote.enable = true; # lanzaboote.nix
  myNixos.services.openssh = {
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
        addr = "192.168.0.56";
        port = 22;
      }
      {
        # Tailscale's IP address
        addr = "${config.myNixos.myOptions.services.tailscale.ip}";
        port = config.myNixos.myOptions.services.tailscale.openssh.port;
      }
    ];
  };
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

  /*
    ═══════════════════════════════
    System
    ═══════════════════════════════
  */
  myNixos.current-system-packages-list.enable = true; # current-system-packages-list.nix
  myNixos.boot.kernelPackages = "xanmod_latest"; # kernel.nix
  myNixos.myOptions.kernel.sysctl.netIpv4TcpCongestionControl = "westwood"; # kernel.nix
  myNixos.services.keyd.enable = true; # keyd.nix
  myNixos.myOptions.services.keyd.addKeydKeyboards = {
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
  myNixos.programs.nix-ld.enable = true; # nix-ld.nix
  myNixos.boot.plymouth = {
    # plymouth.nix
    enable = false;
    theme = "evil-nixos";
  };
  myNixos.networking.timeServers = [ "argentina" ]; # time.nix
  myNixos.time.timeZone = "America/Buenos_Aires"; # time.nix
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
