#---------------------------------------------------------------------
# Martín Cigorraga
# https://github.com/cig0/nixos-config-public
# Firs released on May 1st, 2024
#
# My personal NixOS configuration flake ¯\_(ツ)_/¯
#
# Check at the end of the file for an abridged READ ME! and CHANGELOG.
#---------------------------------------------------------------------

{
  description = "cig0's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    auto-cpufreq = {  # Energy efficiency: https://github.com/AdnanHodzic/auto-cpufreq
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AdnanHodzic/auto-cpufreq";
    };

    flake-compat.url = "github:edolstra/flake-compat";  # Make nixos-option work with flakes.

    home-manager = {  # User-specific settings and packages: https://github.com/nix-community/home-manager
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/home-manager?ref=release-24.11";
    };

    lanzaboote = { # Enable Secure Boot: https://github.com/nix-community/lanzaboote
      inputs.nixpkgs.follows = "nixpkgs";  # Optional but recommended to limit the size of your system closure.
      url = "github:nix-community/lanzaboote/v0.4.1";
    };

    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.5.2.tar.gz";  # Declarative Flatpak management

    nix-index.url = "github:nix-community/nix-index";  # https://github.com/nix-community/nix-index

    nix-ld = {  # https://github.com/nix-community/nix-ld
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:Mic92/nix-ld";
    };

    nixos-cosmic = {
      inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs-stable";
      url = "github:lilyinstarlight/nixos-cosmic";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";  # Hardware-specific optimizations

    nixvim = { # The intended way to configure Neovim.
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-24.11";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    # sops-nix.url = "github:Mic92/sops-nix"; # Secure secrets
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable,
    auto-cpufreq,             # Energy efficiency.
    flake-compat,             # Make nixos-option work with flakes.
    home-manager,             # User-specific settings and packages.
    lanzaboote,               # Secure Boot for NixOS.
    nix-flatpak,              # Enhanced Flatpak support.
    nix-index,                # A files database for nixpkgs.
    nix-ld,                   # Run unpatched dynamic binaries on NixOS.
    nixos-cosmic,             # COSMIC Desktop Environment.
    nixos-hardware,           # Additional hardware configuration.
    nixvim,                   # A Neovim configuration system for nix.
    rust-overlay,             # Oxalica's Rust toolchain overlay.
    # sops-nix,                 # Mic92 NixOS' Mozilla SOPS implementation.
  ... }:

  let
    mergeLists = components: builtins.concatLists components;  # Assemble a list of lists. It's (arguably) a visually cleaner approach for concatenating lists than using ++.
    # mergeSets = components: builtins.foldl' (acc: set: acc // set) {} components;

    # Modules definitions and handling.
      systemModules = {
        # Collections should be defined with roles in mind. Any specific host configuration should be done in the host's configuration section of the flake, or within a specialisations block.
          _all = mergeLists [  # Collection role scope: laptop and workstation.
            systemModules._core
            systemModules._radio
            systemModules.virtualization.containerization
            systemModules.virtualization.hypervisor
          ];
          _core = mergeLists [
            systemModules.applications
            systemModules.cliShell
            systemModules.networking
            systemModules.nixos
            systemModules.nixVim
            systemModules.observability
            systemModules.powerManagement
            systemModules.security
            systemModules.system
          ];
          _radio = mergeLists [
            systemModules.radio.bluetooth
            systemModules.radio.wifi
          ];

        # Imported modules.
          applications  = [  # Install applications systemwide for all hosts.
            ./nixos/modules/applications/applications.nix
            ./nixos/modules/applications/nix-ld.nix
          ];
          cliShell = [
            ./nixos/modules/cli-shell/starship.nix
            ./nixos/modules/cli-shell/zsh/zsh.nix
          ];
          networking = [
            ./nixos/modules/networking/dns.nix
            ./nixos/modules/networking/mtr.nix
            ./nixos/modules/networking/nftables.nix
            ./nixos/modules/networking/stevenblack-unblacklist.nix
            ./nixos/modules/networking/stevenblack.nix
            ./nixos/modules/networking/tailscale.nix
          ];
          nixVim = [
            ./nixos/modules/applications/nixvim.nix nixvim.nixosModules.nixvim
            # ./nixos/modules/system/nix-index-database.nix nix-index-database.nixosModules.nix-index  # TODO: needs more research.
          ];
          observability = [
            # ./nixos/modules/observability/grafana-alloy.nix
            # ./nixos/modules/observability/netdata.nix
            ./nixos/modules/observability/observability.nix  # TODO: evaluate moving logic to the obsevervation module to decide what other modules to enable depending on the host's role.
          ];
          powerManagement = [
            ./nixos/modules/power-management/auto-cpufreq.nix auto-cpufreq.nixosModules.default
            ./nixos/modules/power-management/power-management.nix
          ];
          radio = {
            bluetooth = [ ./nixos/modules/hardware/bluetooth.nix ];
            wifi = [ ./nixos/modules/hardware/wifi.nix ];
          };
          security = [
            ./nixos/modules/security/firewall.nix
            ./nixos/modules/security/gnupg.nix
            ./nixos/modules/security/lanzaboote.nix lanzaboote.nixosModules.lanzaboote
            ./nixos/modules/security/openssh.nix
            # ./nixos/modules/security/sops.nix sops-nix.nixosModules.sops  # TODO: needs implementation.
            ./nixos/modules/security/sudo.nix
          ];
          system = [
            ./nixos/modules/system/environment/environment.nix
            ./nixos/modules/system/maintenance/maintenance.nix
            ./nixos/modules/system/cups.nix
            ./nixos/modules/system/current-system-packages.nix
            ./nixos/modules/system/fwupd.nix
            ./nixos/modules/system/hwaccel.nix
            ./nixos/modules/system/kernel.nix
            ./nixos/modules/system/keyd.nix
            ./nixos/modules/system/ucode.nix
            ./nixos/modules/system/users.nix
            ./nixos/modules/system/zram.nix
          ];
          virtualization = {
            containerization = [
              ./nixos/modules/virtualization/containerization.nix
              ./nixos/modules/virtualization/incus.nix
            ];
            hypervisor = [ ./nixos/modules/virtualization/libvirt.nix ];
          };
      };

      userModules = {
        # Collections should be defined with roles in mind. Any specific host configuration should be done in the host's configuration section of the flake, or within a specialisations block.
          _all = mergeLists [  # Default collection.
            userModules._core
            userModules.audio.audio-subsystem
            userModules.audio.speech-synthesis
            userModules.fonts
            userModules.home-manager
            userModules.nix-flatpak
          ];
          _core = mergeLists [  # Core modules shared by all hosts.
            userModules.displayManagers
            userModules.xdgDesktopPortal
          ];

        # Imported modules.
          audio = {
            audio-subsystem = [ ./nixos/modules/system/audio/audio-subsystem.nix ];
            speech-synthesis = [ ./nixos/modules/system/audio/speech-synthesis.nix ];
          };
          data = [
            ./nixos/modules/applications/syncthing.nix  # TODO: evaluate how to properly manage Syncthing since it requires hard-coding the hosts' IDs.
          ];
          displayManagers = [
            ./nixos/modules/gui-shell/ly.nix
            ./nixos/modules/gui-shell/sddm.nix
          ];
          fonts = [ ./nixos/modules/system/fonts.nix ];
          guiShells = {  # In place to avoid system breakage. Will be removed after refactoring the configuration.
            selector = [
              ./nixos/modules/gui-shell/gui-shell-selector.nix
            ];
            cosmic = [
              ./nixos/modules/gui-shell/cosmic.nix
            ];
            hyprland = [
              ./nixos/modules/gui-shell/hyprland.nix
            ];
            kde = [
              ./nixos/modules/gui-shell/kde-plasma.nix
              ./nixos/modules/applications/kde/kde-pim.nix
              ./nixos/modules/applications/kde/kdeconnect.nix
            ];
            wayfire = [
              ./nixos/modules/gui-shell/wayfire.nix
            ];
            xfce = [
              # ./nixos/modules/gui-shell/xfce.nix
            ];
          };
          home-manager = [ ./home-manager/home.nix home-manager.nixosModules.home-manager ];
          nix-flatpak = [ ./nixos/modules/applications/nix-flatpak.nix nix-flatpak.nixosModules.nix-flatpak ];
          xdgDesktopPortal = [ ./nixos/modules/gui-shell/xdg-desktop-portal.nix ];
      };

    nixos-option = import ./nixos/overlays/nixos-option.nix;
    unstablePkgs = import "${nixpkgs-unstable}" {  # Leverage NixOS might by allowing to mix packages from both the stable and unstable release channels.
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    specialArgs = { inherit inputs system unstablePkgs; };
    system = "x86_64-linux";

  in {
    nixosConfigurations.TUXEDOInfinityBookPro = nixpkgs.lib.nixosSystem {  # Laptop: Intel CPU & GPU
      inherit specialArgs;
      inherit system;
      modules = mergeLists [
        systemModules._all
        userModules._all
        userModules.guiShells.selector  # TODO: remove after refactoring the configuration.
        ] ++ [
          ./nixos/hosts/TUXEDOInfinityBookPro/configuration.nix
          nix-ld.nixosModules.nix-ld
          nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
          {
            nixpkgs.overlays = [
              nixos-option
              rust-overlay.overlays.default
            ];
          }
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

            # TODO: consolidate options in a single place, then import it from the modules that need it
            # mySystem Options, and where they are defined.
            mySystem = {
              guiShellEnv = "plasma6";  # /etc/nixos/nixos-config/nixos/modules/gui-shell/gui-shell-selector.nix
              services = {
                printing = "false";  # /etc/nixos/nixos-config/nixos/modules/system/cups.nix
                # syncthing = "false";  # /etc/nixos/nixos-config/nixos/modules/applications/syncthing.nix  # TODO: commented out to avoid breaking the build. I will remove this option anyway.
                tailscale = "true";  # /etc/nixos/nixos-config/nixos/modules/networking/tailscale.nix
              };
            };
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


# README!
# =======
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

  # Changelog
  # =========
  # 2024-12-31  Lots of refactoring and improvements. Check the commit history for details.
  # 2024-12-25  Finished splitting the Zsh shell aliases and functions into modules 🎉
  # 2024-12-21  KDE Plasma: move activation logic to the module file.
  # 2024-12-21  Syncthing: move activation logic to the module file.
  # 2024-12-21  CUPS: move activation logic to the module file.
  # 2024-12-21  Tailscale: move activation logic to the module file.
