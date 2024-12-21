#---------------------------------------------------------------------
# Martín Cigorraga
# https://github.com/cig0/nixos-config-public
# May 1st, 2024
#
# My personal NixOS configuration flake ¯\_(ツ)_/¯
#
# Check at the end of the file for an abridged file README.
#---------------------------------------------------------------------


{
  description = "cig0's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    auto-cpufreq = { # Energy efficiency: https://github.com/AdnanHodzic/auto-cpufreq
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AdnanHodzic/auto-cpufreq";
    };

    home-manager = { # User-specific settings and packages: https://github.com/nix-community/home-manager
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/home-manager?ref=release-24.11";
    };

    lanzaboote = { # Enable Secure Boot: https://github.com/nix-community/lanzaboote
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

    nixvim = { # The intended way to configure Neovim.
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-24.11";
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
    nixvim,
    rust-overlay,             # Oxalica's Rust toolchain overlay.
    # sops-nix,                 # Mic92 NixOS' Mozilla SOPS implementation.
  ... }:

  let
    # Modules definitions and handling.
      coreModules = [ # Modules shared by all hosts.
        # Applications
          ({ pkgs, ... }: { # Rust
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          })
          ./nixos/modules/applications/current-system-packages.nix

        # Assembly
          ./nixos/modules/applications/packages/assembly.nix

        # CLI Shell
          ./nixos/modules/cli-shell/starship.nix
          ./nixos/modules/cli-shell/zsh/zsh.nix

        # Data
          ./nixos/modules/applications/syncthing.nix  # TODO: move logic to the assemble file.

        # Networking
          ./nixos/modules/networking/dns.nix
          ./nixos/modules/networking/mtr.nix
          ./nixos/modules/networking/nftables.nix
          ./nixos/modules/networking/stevenblack.nix
          ./nixos/modules/networking/stevenblack-unblacklist.nix
          ./nixos/modules/networking/tailscale.nix

        # NixVim
          ./nixos/modules/applications/nixvim.nix nixvim.nixosModules.nixvim

        # Observability
          # ./nixos/modules/observability/grafana-alloy.nix
          # ./nixos/modules/observability/netdata.nix
          ./nixos/modules/observability/observability.nix  # TODO: evaluate moving logic to the obsevervation module to decide what other modules to enable depending on the host's role.

        # Power management
          ./nixos/modules/power-management/auto-cpufreq.nix auto-cpufreq.nixosModules.default
          ./nixos/modules/power-management/power-management.nix

        # Security
          ./nixos/modules/security/firewall.nix
          ./nixos/modules/security/gnupg.nix
          ./nixos/modules/security/lanzaboote.nix lanzaboote.nixosModules.lanzaboote
          ./nixos/modules/security/openssh.nix
          # ./nixos/modules/security/sops.nix sops-nix.nixosModules.sops  # TODO: needs implementation.
          ./nixos/modules/security/sudo.nix

        # System
          ./nixos/modules/system/cups.nix
          ./nixos/modules/system/environment.nix
          ./nixos/modules/system/fwupd.nix
          ./nixos/modules/system/hwaccel.nix
          ./nixos/modules/system/kernel.nix
          ./nixos/modules/system/keyd.nix
          ./nixos/modules/system/maintenance.nix
          # ./nixos/modules/system/osquery.nix  # TODO: needs implementation.
          # ./nixos/modules/system/nix-index-database.nix nix-index-database.nixosModules.nix-index  # TODO: needs more research.
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

      userModules = [ # Modules specific to the user, e.g. GUI apps.
        # Applications
          ./home-manager/home.nix home-manager.nixosModules.home-manager
          ./nixos/modules/applications/chromium.nix
          ./nixos/modules/applications/firefox.nix
          ./nixos/modules/applications/nix-flatpak.nix nix-flatpak.nixosModules.nix-flatpak

        # Display Managers
          ./nixos/modules/gui-shell/ly.nix
          ./nixos/modules/gui-shell/sddm.nix

        # GUI shells
          # New unified GUI shells handling!
          # Just set the GUI shell to use in the host definition, the modules will handle the rest :)
          # The only valid values so far are "plasma6" or "none".
          ./nixos/modules/gui-shell/by-gui-shell.nix

        # System
          ./nixos/modules/system/fonts.nix
          ./nixos/modules/system/speech-synthesis.nix
      ];

    system = "x86_64-linux";
    unstablePkgs = import "${nixpkgs-unstable}" {  # Leverage NixOS mighty by allowing to mix packages from both the stable and unstable release channels.
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

  in {
    nixosConfigurations.perrrkele = nixpkgs.lib.nixosSystem {  # Laptop: Intel CPU & GPU
      inherit system;
      specialArgs = { inherit inputs system unstablePkgs; };
      modules =
        coreModules ++
        userModules ++
        [
        nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
        ./nixos/hosts/perrrkele/configuration.nix

        {
          # Host configutation
            # ===== DISPLAY MANAGERS =====
            # Only one at a time can be active.
            # Settings for each Display Manager are managed in the respective modules in ./nixos/modules/gui-shell/
            services.displayManager = {
              autoLogin = {
                enable = false;
              };
              # cosmic-greeter.enable = false;  # COSMIC Desktop Greeter
              ly.enable = false;  # Ly Display Manager
              sddm.enable = true;  # SDDM / KDE Display Manager
            };

            # ===== GUI SHELL =====
            mySystem.guiShellEnv = "plasma6";

            # ===== SERVICES =====
            mySystem.services.syncthing = "false";
        }
      ];
    };

    # nixosConfigurations.satama = nixpkgs.lib.nixosSystem { # headless MiniPC: Intel CPU & GPU, lab + NAS + streaming
    #   inherit system;
    #   specialArgs = { inherit inputs system unstablePkgs; };
    #   modules = coreModules ++ [
    #     ./nixos/hosts/satama/configuration.nix

    #     {
    #     }
    #   ];
    # };

    # nixosConfigurations.koira = nixpkgs.lib.nixosSystem { # desktop: Intel CPU, Nvidia GPU
    #   inherit system;
    #   specialArgs = { inherit inputs system unstablePkgs; };
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
    #     # TODO: Nvidia drivers
    #   ];
    # };
  };
}


# File README
# ===========

# - The COSMIC desktop environment options are disabled to avoid sourcing the flake when building the system configuration.

# About the design of the configuration:
# Importing everything and having each module self-check is inefficient and inelegant. It goes against the goal of having a lean, dynamic configuration where only what's needed gets included.

# The fundamental problem we're facing stems from NixOS's module system design:
  # imports must be determined before configuration evaluation
  # We want imports to be determined by configuration values
  # This creates an inherent circular dependency
  # This is probably why NixOS itself often uses the "import everything and let modules self-activate" pattern, even though it's not ideal.

# This touches on an interesting aspect of real-world systems: sometimes we have to choose between theoretical elegance and practical functionality. The "import everything and self-activate" pattern, while not ideal from a design perspective:
  # Is proven to work within NixOS's constraints
  # Is predictable because it follows established patterns
  # Avoids edge cases and timing issues in module evaluation
  # Is maintainable because it's simple (if inefficient)