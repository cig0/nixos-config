#---------------------------------------------------------------------
# Martín Cigorraga
# https://github.com/cig0/nixos-config-public
# May 1st, 2024
#
# My personal NixOS configuration flake ¯\_(ツ)_/¯
#---------------------------------------------------------------------


{
  description = "cig0's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    auto-cpufreq = { # Energy efficiency
      inputs.nixpkgs.follows = "nixpkgs"; # Commented out since we track the NixOS stable branch, not unstable.
      url = "github:AdnanHodzic/auto-cpufreq";
    };

    home-manager = { # Maybe in the future
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/home-manager?ref=release-24.11";
    };

    lanzaboote = {
      inputs.nixpkgs.follows = "nixpkgs"; # Optional but recommended to limit the size of your system closure.
      url = "github:nix-community/lanzaboote/v0.4.1";
    };

    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.4.1.tar.gz"; # Declarative Flatpak management

    # nixos-cosmic = {
    #   inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs-stable";
    #   url = "github:lilyinstarlight/nixos-cosmic";
    # };

    nix-index.url = "github:nix-community/nix-index";

    # nix-index-database = {
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   url = "github:nix-community/nix-index-database"; # TODO: learn how to implement it properly.
    # };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; # Hardware-specific optimizations

    nixvim = { # The intended way to configure Neovim?
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
    };

    rust-overlay.url = "github:oxalica/rust-overlay"; # A happy crabby dancing sideways

    # sops-nix.url = "github:Mic92/sops-nix"; # Secure secrets
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable,
    auto-cpufreq,             # Energy efficiency.
    home-manager,             # User-specific settings and packages.
    lanzaboote,               # Secure Boot for NixOS.
    nix-flatpak,              # Enhanced Flatpak support.
    nix-index,                # A files database for nixpkgs.
    # nix-index-database,       # A files database for nixpkgs - pre-baked.
    # nixos-cosmic,             # COSMIC Desktop Environment.
    nixos-hardware,           # Additional hardware configuration.
    nixvim,                   # WIP Neovim configuration (rocking on LunarVim ATM).
    rust-overlay,             # Oxalica's Rust toolchain overlay.
    # sops-nix,                 # Mic92 NixOS' Mozilla SOPS implementation.
  ... }:

  let
    commonModules = [
      # Applications
        ({ pkgs, ... }: { # Rust
          nixpkgs.overlays = [ rust-overlay.overlays.default ];
          environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
        })
        ./nixos/modules/applications/current-system-packages.nix

      # Assembly
        ./nixos/modules/assembly/assemble.nix

      # Data
        ./nixos/modules/applications/syncthing.nix # TODO: move logic to the assemble file.

      # Networking related
        ./nixos/modules/networking/dns.nix
        ./nixos/modules/networking/nftables.nix
        ./nixos/modules/networking/stevenblack.nix
        ./nixos/modules/networking/stevenblack-unblacklist.nix
        ./nixos/modules/networking/tailscale.nix

      # Nixvim
        ./nixos/modules/applications/nixvim.nix nixvim.nixosModules.nixvim

      # Observability
        ./nixos/modules/observability/observability.nix

      # Power management
        ./nixos/modules/power-management/auto-cpufreq.nix auto-cpufreq.nixosModules.default
        ./nixos/modules/power-management/power-management.nix

      # Security
        ./nixos/modules/security/firewall.nix
        ./nixos/modules/security/gnupg.nix
        ./nixos/modules/security/lanzaboote.nix lanzaboote.nixosModules.lanzaboote
        ./nixos/modules/security/openssh.nix
        # ./nixos/modules/security/sops.nix sops-nix.nixosModules.sops
        ./nixos/modules/security/sudo.nix

      # Shell
        ./nixos/modules/shell/starship.nix
        ./nixos/modules/shell/zsh/zsh.nix

      # System
        ./nixos/modules/system/cups.nix
        ./nixos/modules/system/environment.nix
        ./nixos/modules/system/fwupd.nix
        ./nixos/modules/system/hwaccel.nix
        ./nixos/modules/system/kernel.nix
        ./nixos/modules/system/keyd.nix
        ./nixos/modules/system/maintenance.nix
        # ./nixos/modules/system/nix-index-database.nix nix-index-database.nixosModules.nix-index
        ./nixos/modules/system/time.nix
        ./nixos/modules/system/ucode.nix
        ./nixos/modules/system/users.nix
        ./nixos/modules/system/zram.nix

      # Virtualization
        ./nixos/modules/virtualisation/containerization.nix
        ./nixos/modules/virtualisation/incus.nix
        ./nixos/modules/virtualisation/libvirt.nix

      # Import Overlays
        ./nixos/overlays/overlays.nix
    ];

    userSideModules = [
      # Applications - Flatpak
        ./home-manager/home.nix home-manager.nixosModules.home-manager
        ./nixos/modules/applications/nix-flatpak.nix nix-flatpak.nixosModules.nix-flatpak

      # Display Managers / Desktop Environments / Window Managers
        # ./nixos/modules/desktop/cosmic.nix nixos-cosmic.nixosModules.default
        # ./nixos/modules/desktop/gnome.nix
        ./nixos/modules/desktop/kde.nix
        ./nixos/modules/desktop/ly.nix
        ./nixos/modules/desktop/sddm.nix
        ./nixos/modules/desktop/xdg-desktop-portal.nix

      # System - GUI
        ./nixos/modules/system/fonts.nix
    ];

    system = "x86_64-linux";

    unstablePkgs = import "${nixpkgs-unstable}" {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [ "openssl-1.1.1w" ]; # Sublime 4
      };
    };

  in
  {
    nixosConfigurations.perrrkele = nixpkgs.lib.nixosSystem { # laptop: Intel CPU & GPU
      inherit system;
      specialArgs = { inherit inputs system unstablePkgs; };
      modules = commonModules ++ userSideModules ++ [
        nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
        ./nixos/hosts/perrrkele/configuration.nix

        {
          services.desktopManager = {
            # cosmic.enable = false; # COSMIC Desktop Environment
            plasma6.enable = true; # KDE Plasma Desktop Environment
          };

          # ===== DISPLAY MANAGERS =====
          # Only one at a time can be active.
          # Settings for each Display Manager are managed in the respective modules in ./nixos/modules/desktop/
          services.displayManager = {
            autoLogin = {
              enable = false;
            };
            # cosmic-greeter.enable = false; # COSMIC Desktop Greeter
            ly.enable = false; # Ly Display Manager
            sddm.enable = true; # SDDM / KDE Display Manager
          };
        }
      ];
    };

    # nixosConfigurations.satama = nixpkgs.lib.nixosSystem { # headless MiniPC: Intel CPU & GPU, lab + NAS + streaming
    #   inherit system;
    #   specialArgs = { inherit inputs system unstablePkgs; };
    #   modules = commonModules ++ [
    #     ./nixos/hosts/satama/configuration.nix

    #     {
    #     }
    #   ];
    # };

    # nixosConfigurations.vittusaatana = nixpkgs.lib.nixosSystem { # desktop: Intel CPU, Nvidia GPU
    #   inherit system;
    #   specialArgs = { inherit inputs system unstablePkgs; };
    #   modules = commonModules ++ userSideModules ++ [
    #     ./nixos/hosts/vittusaatana/configuration.nix

    #     {
    #       services.desktopManager.plasma6.enable = true; # KDE Plasma Desktop Environment
    #       programs.dconf.enable = true; # https://wiki.nixos.org/wiki/KDE#Installation

    #       # ===== DISPLAY MANAGERS =====
    #       # Only one at a time can be active
    #         #####  THIRD-PARTY MODULES  #####
    #         # services.displayManager.cosmic-greeter.enable = false; # COSMIC Greeter
    #       services.displayManager.sddm.enable = true; # SDDM / KDE Display Manager
    #     }
    #     # TODO: Nvidia drivers
    #   ];
    # };
  };
}