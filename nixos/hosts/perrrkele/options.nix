# TODO: Consider splitting into modules under nixos/profiles (../../profiles)
# Splitting may improve options management but risks obfuscating the host config.
{
  config,
  pkgs,
  ...
}:
{
  # ░░░░░░░█▀█░█▀▀░█▀▄░█▀▄░█▀▄░█░█░█▀▀░█░░░█▀▀░▀░█▀▀░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
  # ░░░░░░░█▀▀░█▀▀░█▀▄░█▀▄░█▀▄░█▀▄░█▀▀░█░░░█▀▀░░░▀▀█░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
  # ░░░░░░░▀░░░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░▀▀▀░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░
  # For Home Manager options, check home-manager/home.nix

  # NixOS host-specific options
  # Hardware
  hardware.cpu.intel.updateMicrocode = true;

  # Programs
  programs = {
    appimage = {
      # "https://wiki.nixos.org/wiki/Appimage"
      enable = true;
      binfmt = true;
    };

    firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = "1";
      }; # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
    };

    fuse.userAllowOther = true; # Recommended for programs.appimage

    lazygit = {
      enable = true;
      settings = {
        gui = {
          scrollPastBottom = false;
        };
        git = {
          commit = {
            signOff = true;
            autoWrapCommitMessage = false;
          };
          merging = {
            manualCommit = true;
          };
          update = {
            method = "background";
            days = 14;
          };
          os = {
            edit = "${config.mySystem.cli.editor} {{filename}}";
            editAtLine = "${config.mySystem.cli.editor} {{filename}} +{{line}}";
            editInTerminal = true;
            openDirInEditor = "${config.mySystem.cli.editor} {{dir}}";
          };
        };
        promptToReturnFromSubprocess = false;
      };
    };
  };

  # Services
  services = {
    flatpak = {
      # https://github.com/gmodena/nix-flatpak?tab=readme-ov-file
      # Depends on: ../../modules/applications/nix-flatpak.nix
      enable = true;
      packages = config._module.args.nix-flatpak.packages.all;
      update = {
        auto = {
          enable = true;
          onCalendar = "weekly"; # Default value
        };
        onActivation = false;
      };
      uninstallUnmanaged = true;
    };

    fwupd.enable = true;
    zram-generator.enable = true;
  };

  # Systemd
  systemd.services."flatpak-managed-install" = {
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
    }; # Required for services.flatpak to work properly
  };

  # ZramSwap
  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 15;
  };

  # Options overrides from modules
  mySystem = {
    # Applications
    programs.git = {
      enable = true;
      lfs.enable = true;
    };

    programs.kde-pim.enable = false;
    programs.kdeconnect.enable = true;
    programs.krew = {
      # TODO: wip
      enable = true;
      install = [
        "ctx"
        "ktop"
        "ns"
        "slowdrain"
      ];
    };
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

    # GUI shell
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
