#------------------------------------------------------------------
# My personal NixOS configuration flake ¯\_(ツ)_/¯
#
# Martín Cigorraga
# https://github.com/cig0/nixos-config-public
# Initial release on May 1st, 2024
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

    flake-compat.url = "github:edolstra/flake-compat"; # Make nixos-option work with flakes.

    home-manager = {
      # User-specific settings and packages: https://github.com/nix-community/home-manager
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?ref=release-24.11";
    };

    lanzaboote = {
      # Enable Secure Boot: https://github.com/nix-community/lanzaboote
      inputs.nixpkgs.follows = "nixpkgs"; # Optional but recommended to limit the size of your system closure.
      url = "github:nix-community/lanzaboote/v0.4.2";
    };

    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.5.2.tar.gz"; # Declarative Flatpak management

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

    # sops-nix.url = "github:Mic92/sops-nix";  # Secure secrets
  };

  outputs = inputs @ {
    auto-cpufreq, # Energy efficiency.
    flake-compat, # Make nixos-option work with flakes.
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
    # sops-nix, # Mic92 NixOS' Mozilla SOPS implementation.  # TODO: to implement.
    ...
  }: let
    # mySystem = import [];
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
      # ./nixos/profiles/default.nix
    ];

    nixos-option = import ./nixos/overlays/nixos-option.nix;
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
          ./nixos/hosts/TUXEDOInfinityBookPro/configuration.nix
          {
            # ░░░░░░░█▀█░█░█░█▀▀░█▀▄░█░░░█▀█░█░█░█▀▀░░░░░░░
            # ░░░░░░░█░█░▀▄▀░█▀▀░█▀▄░█░░░█▀█░░█░░▀▀█░░░░░░░
            # ░░░░░░░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░░▀▀▀░░░░░░░
            nixpkgs.overlays = [
              nixos-option
              rust-overlay.overlays.default
            ];
          }
          {
            # ░░░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
            # ░░░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
            # ░░░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░

            # NixOS - System
            programs.fuse.userAllowOther = true;

            mySystem = {
              # Applications
              packages.baseline = true;
              packages.cli._all = true;
              packages.gui = true;
              packages.guiShell.kde = true;
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
              security.sudo.enable = true;
              # Security - Firewall
              networking.firewall.enable = true;
              networking.firewall.allowPing = false;

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

    # nixosConfigurations.satama = nixpkgs.lib.nixosSystem { # headless MiniPC: Intel CPU & GPU, lab + NAS + streaming
    #   inherit system;
    #   specialArgs = { inherit inputs system pkgsUnstable; };
    #   modules = coreModules ++ [
    #     ./nixos/hosts/satama/configuration.nix

    #     {
    #     }
    #   ];
    # };

    # nixosConfigurations.koira = nixpkgs.lib.nixosSystem { # desktop: Intel CPU, Nvidia GPU
    #   inherit system;
    #   specialArgs = { inherit inputs system pkgsUnstable; };
    #   modules = coreModules ++ userModules ++ [
    #     ./nixos/hosts/koira/configuration.nix

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
