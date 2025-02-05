#------------------------------------------------------------------
# My personal NixOS multi-host configuration flake ¯\_(ツ)_/¯
#
# By Martín Cigorraga
# https://github.com/cig0/nixos-config
# Initial release on May 1st, 2024
#
# ASCII art credits: https://www.asciiart.eu/ 🙌
#------------------------------------------------------------------
#                                                                     _------__--___.__.
#                                                                   /            `  `    \
#                                                                  |                      \
#                                                                  |                       |
#                                                                   \                      |
#                                                                     ~/ --`-`-`-\         |
#                                                                     |            |       |
#                                                                     |            |       |
#                                                                      |   _--    |       |
#                                                   Hey Butthead,      _| =-.    |.-.    |
#                                                                      o|/o/       _.   |
#                                                  does this suck?     /  ~          \ |
#                                                                    (____@)  ___~    |
#                                                                       |_===~~~.`    |
#                                                                    _______.--~     |
#                                                                    \________       |
#                                                                             \      |
#                                                                           __/-___-- -__
#                                                                          /            __\
#                                                                         /-| Metallica|| |
#                                                                        / /|          || |
{
  description = "cig0's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    auto-cpufreq = {
      # Energy efficiency: https://github.com/AdnanHodzic/auto-cpufreq
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AdnanHodzic/auto-cpufreq";
    };

    # TODO: To be deprecated with the release of 25.05 :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-2637395681
    flake-compat.url = "github:edolstra/flake-compat"; # Make nixos-option work with flakes.

    home-manager = {
      # User-specific settings and packages: https://github.com/nix-community/home-manager
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?ref=release-24.11";
    };

    lanzaboote = {
      # Enable Secure Boot: https://github.com/nix-community/lanzaboote
      inputs.nixpkgs.follows = "nixpkgs"; # Optional but recommended to limit the size of your system closure
      url = "github:nix-community/lanzaboote/v0.4.2";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # Declarative Flatpak management for NixOS

    nix-index.url = "github:nix-community/nix-index"; # https://github.com/nix-community/nix-index

    nix-ld = {
      # https://github.com/nix-community/nix-ld
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:Mic92/nix-ld";
    };

    nixos-cosmic = {
      inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs-stable";
      url = "github:lilyinstarlight/nixos-cosmic";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; # Hardware-specific optimizations

    nixvim = {
      # The intended way to configure Neovim
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-24.11";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    # sops-nix.url = "github:Mic92/sops-nix"; # Secure secrets
  };

  outputs = {
    auto-cpufreq, # Energy efficiency.
    flake-compat, # Make nixos-option work with flakes. # TODO: To be deprecated with the release of 25.05 :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-2637395681
    home-manager, # User-specific settings and packages.
    lanzaboote, # Secure Boot for NixOS.
    nix-flatpak, # Enhanced Flatpak support.
    nix-index, # A files database for nixpkgs.
    nix-ld, # Run unpatched dynamic binaries on NixOS.
    nixos-cosmic, # COSMIC Desktop Environment.
    nixos-hardware, # Additional hardware configuration.
    nixpkgs,
    nixpkgs-unstable,
    nixvim, # A Neovim configuration system for nix.
    rust-overlay, # Oxalica's Rust toolchain overlay.
    self,
    # sops-nix, # Mic92 NixOS' Mozilla SOPS implementation. # TODO: pending implementation.
    ...
  } @ inputs: let
    modules = [
      # ░░░░░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀░░░░░░░
      # ░░░░░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█░░░░░░░
      # ░░░░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░
      ./home-manager/home.nix
      ./nixos/modules/applications/default.nix
      ./nixos/modules/hardware/default.nix
      ./nixos/modules/networking/default.nix
      ./nixos/modules/observability/default.nix
      ./nixos/modules/security/default.nix
      ./nixos/modules/system/default.nix
      ./nixos/modules/virtualisation/default.nix
      # ./nixos/profiles/default.nix # WIP
    ];

    nixos-option = import ./nixos/overlays/nixos-option.nix; # TODO: To be deprecated with the release of 25.05 :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-2637395681
    pkgsUnstable = import nixpkgs-unstable {
      # Leverage NixOS might by allowing to mix packages from both the stable and unstable release channels
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    specialArgs = {inherit inputs system pkgsUnstable;};
    system = "x86_64-linux";
  in {
    nixosConfigurations.TUXEDOInfinityBookPro = nixpkgs.lib.nixosSystem {
      # Laptop: Intel CPU & GPU + KDE
      inherit specialArgs;
      inherit system;
      modules =
        modules
        ++ [
          inputs.nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
          ./nixos/hosts/TUXEDOInfinityBookPro/configuration.nix
          {
            # ░░░░░░░█▀█░█░█░█▀▀░█▀▄░█░░░█▀█░█░█░█▀▀░░░░░░░
            # ░░░░░░░█░█░▀▄▀░█▀▀░█▀▄░█░░░█▀█░░█░░▀▀█░░░░░░░
            # ░░░░░░░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░░▀▀▀░░░░░░░
            nixpkgs.overlays = [
              nixos-option # TODO: To be deprecated with the release of 25.05 :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-2637395681
              rust-overlay.overlays.default
            ];
          }
          {
            # ░░░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
            # ░░░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
            # ░░░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░

            # NixOS - System
            programs = {
              # https://wiki.nixos.org/wiki/Appimage
              appimage = {
                enable = true;
                binfmt = true;
              };
              fuse.userAllowOther = true;
            };

            mySystem = {
              # Applications - From NixOS options
              programs.git.enable = true;
              programs.git.lfs.enable = true;
              programs.lazygit.enable = true;
              programs.nh.enable = true;
              programs.nixvim.enable = true;
              programs.firefox.enable = true;
              services.flatpak.enable = true;
              programs.kdeconnect.enable = true;
              programs.kde-pim.enable = false;
              services.tailscale.enable = true;
              programs.zsh.enable = true;
              # Applications - From packages
              packages.baseline = true;
              packages.cli._all = true;
              packages.gui = true;
              packages.guiShell.kde = true;

              # GUI shell
              services.displayManager.ly.enable = false;
              services.displayManager.sddm.enable = true;
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
              networking.networkmanager.dns = "systemd-resolved";
              networking.networkmanager.enable = true;

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
              networking.firewall.enable = true;
              networking.firewall.allowPing = false;
              # Security - Sudo
              security.sudo.enable = true;
              security.sudo.extraConfig = ''
                Defaults passwd_timeout=1440, timestamp_timeout=1440
              ''; # From a security perspective, it isn't a good idea to extend the sudo *_timeout (let alone doing so on a server!). I set this on my personal laptop and desktop for convenience.

              # System
              current-system-packages-list.enable = true;
              services.fwupd.enable = true;
              programs.nix-ld.enable = true;
              # System - Audio
              audio-subsystem.enable = true;
              services.speechd.enable = true;
              # System - Kernel
              boot.kernelPackages = "xanmod_latest";
              # System - Maintenance
              nix.settings.auto-optimise-store = true;
              nix.gc.automatic = true;
              system.autoUpgrade.enable = true;
              # System - Time
              networking.timeServers = ["argentina"];
              time.timeZone = "America/Buenos_Aires";
              # System - User management
              users.users.doomguy = true;

              # Virtualisation
              virtualisation.incus.enable = true;
              virtualisation.libvirtd.enable = true;
              virtualisation.podman.enable = true;
            };
          }
        ];
    };

    # nixosConfigurations.homelabnas = nixpkgs.lib.nixosSystem { # headless MiniPC: Intel CPU & GPU, lab + NAS + streaming
    #   inherit system;
    #   specialArgs = { inherit inputs system pkgsUnstable; };
    #   modules = coreModules ++ [
    #     ./nixos/hosts/homelabnas/configuration.nix

    #     {
    #     }
    #   ];
    # };

    # nixosConfigurations.desktop = nixpkgs.lib.nixosSystem { # desktop: Intel CPU, Nvidia GPU
    #   inherit system;
    #   specialArgs = { inherit inputs system pkgsUnstable; };
    #   modules = coreModules ++ userModules ++ [
    #     ./nixos/hosts/desktop/configuration.nix

    #     {
    #       services.desktopManager.plasma6.enable = true; # KDE Plasma Desktop Environment
    #       programs.dconf.enable = true; # https://wiki.nixos.org/wiki/KDE#Installation

    #       # ===== DISPLAY MANAGERS =====
    #       # Only one at a time can be active
    #         #####  THIRD-PARTY MODULES  #####
    #         # services.displayManager.cosmic-greeter.enable = false; # COSMIC Greeter
    #       services.displayManager.sddm.enable = true; # SDDM / KDE Display Manager
    #     }
    #   ];
    # };
  };
}
