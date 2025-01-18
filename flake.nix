#---------------------------------------------------------------------
# Martín Cigorraga
# https://github.com/cig0/nixos-config-public
# Firs released on May 1st, 2024
#
# My personal NixOS configuration flake ¯\_(ツ)_/¯
#
# Check at the end of the file for an abridged READ ME! and CHANGELOG.
#---------------------------------------------------------------------
#            ===.
#        =====.==`.               __,------._
#           ===`.8=);   _/)    .-'           ``-.
#           _ (G^ @@__ / '.  .'    By Toutatis,  `.
#     ,._,-'_`-/,-^( _).__: .'    this flake is   :
#    (    / .MMm.Y_)/      ,'     looking great!  |
#     `'(|.oMMMM       __,',-'`._               ,'
#     d88:'mOom        `--'      `-..______,--''
#     88::(::\d88b
#     Y88  ':88888
#  _________888P__________________________________________________osfa
#                                                                                       _------__--___.__.
#                                                                                     /            `  `    \
#                                                                                    |                      \
#                                                                                    |                       |
#                                                                                     \                      |
#                                                                                       ~/ --`-`-`-\         |
#                                                                                       |            |       |
#                                                                                       |            |       |
#                                                                                        |   _--    |       |
#                                                                     Hey Butthead,      _| =-.    |.-.    |
#                                                                                        o|/o/       _.   |
#                                                                    does this suck?     /  ~          \ |
#                                                                                      (____@)  ___~    |
#                                                                                         |_===~~~.`    |
#                                                                                      _______.--~     |
#                                                                                      \________       |
#                                                                                               \      |
#                                                                                             __/-___-- -__
#                                                                                            /            __\
#                                                                                           /-| Metallica|| |
#                                                                                          / /|          || |
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
      url = "github:nix-community/lanzaboote/v0.4.1";
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
    modules = [
      ./home-manager/home.nix
      ./nixos/modules/applications/main.nix
      ./nixos/modules/hardware/main.nix
      ./nixos/modules/networking/main.nix
      ./nixos/modules/observability/main.nix
      ./nixos/modules/security/main.nix
      ./nixos/modules/system/main.nix
      ./nixos/modules/virtualisation/main.nix

      # <----------------  TO GO  ------------------>
      ./nixos/modules/applications/nixvim.nix # TODO: investigate moving to Home Manager
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
            # Overlays
            nixpkgs.overlays = [
              nixos-option
              rust-overlay.overlays.default
            ];
          }
          {
            #        ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
            #       ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
            #       ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
            #       ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
            #       ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
            #        ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

            mySystem = {
              # Applications (from ./nixos/modules/applications/packages.nix)
              packages.baseline = true;
              packages.cli._all = true;
              packages.gui = true;
              packages.guiShell.kde = true;

              # Applications (from options)
              programs.nh.enable = true;
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
              power-management.enable = true;
              services.thermald.enable = true;

              # Radio
              hardware.bluetooth.enable = true;

              # Security
              networking.firewall.enable = true;
              programs.gnupg.enable = true;
              boot.lanzaboote.enable = true;
              services.openssh.enable = true;
              security.sudo.enable = true;

              # System
              current-system-packages-list = true;
              services.fwupd.enable = true;
              programs.nix-ld.enable = true;
              # Audio
              audio-subsystem = true;
              services.speech-synthesis.enable = true;
              # Maintenance
              nix.settings.auto-optimise-store = true;
              nix.gc.automatic = true;
              system.autoUpgrade.enable = true;

              # Virtualisation
              virtualisation.incus.enable = true;
              virtualisation.libvirt.enable = true;
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
