/*
  ------------------------------------------------------------------------
  My personal NixOS multi-host configuration flake ¯\_(ツ)_/¯
  https://github.com/cig0/nixos-config
  Kickoff commit on May 29th 2024, 4:20 AM.
  Initial public release on ${TBD}.

  ASCII art credits: https://www.asciiart.eu/cartoons/beavis-and-butt-head
  ------------------------------------------------------------------------
                                                                           _------__--___.__.
                                                                         /            `  `    \
                                                                        |                      \
                                                                        |                       |
                                                                         \                      |
                                                                           ~/ --`-`-`-\         |
                                                                           |            |       |
                                                                           |            |       |
                                                                            |   _--    |       |
                                                         Hey Butthead,      _| =-.    |.-.    |
                                                                            o|/o/       _.   |
                                                        does this suck?     /  ~          \ |
                                                                          (____@)  ___~    |
                                                                             |_===~~~.`    |
                                                                          _______.--~     |
                                                                          \________       |
                                                                                   \      |
                                                                                 __/-___-- -__
                                                                                /            __\
                                                                               /-| Metallica|| |
                                                                              / /|          || |
*/

/*
  NixOS Configuration Strategy:
  - Base configuration implements NixOS modules with default values for all hosts
  - Host-specific options as well as module override options are defined in each host's
  `profile.nix` module
  - The module `configuration.nix` handles core system setup (as in a fresh NixOS installation)

  Home Manager Configuration Strategy:
  - The HM entry point is the module `configs/home-manager/home.nix`
  - The module `home.nix` has the dynamic modules loader invocation

  This separation keeps configurations modular and maintainable.
*/
{
  description = "cig0's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11"; # NixOS release channel
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # The unstable release channel to allow for fresher packages

    # Energy efficiency for battery-powered devices
    auto-cpufreq = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AdnanHodzic/auto-cpufreq";
    };

    # Determinate is an end-to-end toolchain for using Nix
    determinate = {
      inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    };

    dynamic-module-importer = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cig0/module-loader"; # Replace with your repo
    };

    # flakehub = {
    # Home Manager: user-specific packages and settings
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?ref=release-24.11";
    };

    # Secure Boot for NixOS
    lanzaboote = {
      inputs.nixpkgs.follows = "nixpkgs"; # Optional but recommended to limit the size of the system closure
      url = "github:nix-community/lanzaboote/v0.4.2";
    };

    # Declarative Flatpak management for NixOS
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # A files database for nixpkgs{-unstable}
    nix-index.url = "github:nix-community/nix-index";

    # Weekly updated nix-index database for nixos-unstable channel
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/nix-index-database";
    };

    # Run unpatched dynamic binaries on NixOS
    nix-ld = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:Mic92/nix-ld";
    };

    # COSMIC Desktop Environment
    nixos-cosmic = {
      inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs-stable";
      url = "github:lilyinstarlight/nixos-cosmic";
    };

    # Additional hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Snapd support for NixOS
    nix-snapd = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/nix-snapd";
    };

    # A Neovim configuration system for Nix
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-24.11";
    };

    plymouth-is-underrated = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cig0/plymouth-is-underrated-cab404";
    };

    # Oxalica's Rust toolchain overlay
    rust-overlay.url = "github:oxalica/rust-overlay";

    # Atomic, declarative, and reproducible secret provisioning for NixOS based on Mozilla SOPS
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    # Blazing fast terminal file manager written in Rust, based on async I/O
    yazi.url = "github:sxyazi/yazi";
  };

  outputs =
    {
      auto-cpufreq,
      determinate,
      dynamic-module-importer,
      home-manager,
      lanzaboote,
      nix-flatpak,
      nix-index,
      nix-index-database,
      nix-ld,
      nix-snapd,
      nixos-cosmic,
      nixos-hardware,
      nixpkgs,
      nixpkgs-unstable,
      nixvim,
      plymouth-is-underrated,
      rust-overlay,
      self,
      sops-nix,
      yazi,
      ...
    }@inputs:
    let
      # Import external libraries
      mkLibrary = system: {
        ansiColors = import ./lib/ansi-colors { };
        moduleImporter = dynamic-module-importer.lib.${system};
      };

      /*
         The mkHostConfig function:
         - Creates a NixOS system configuration for each host
         - Applies common modules, overlays, configurations, and (optionally) Home Manager as a
         module across all hosts
         - Incorporates host-specific settings from individual host profiles
         - Enables dynamic module loading for easy extensibility
      */
      mkHostConfig =
        hostname: hostConfig:
        let
          library = mkLibrary hostConfig.system;
          system = hostConfig.system;
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            libraryAnsiColors = library.ansiColors;
            libraryModuleImporter = library.moduleImporter;
          };
          modules = [
            auto-cpufreq.nixosModules.default
            determinate.nixosModules.default
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            nix-index-database.nixosModules.nix-index
            nix-flatpak.nixosModules.nix-flatpak
            nix-ld.nixosModules.nix-ld
            nix-snapd.nixosModules.default
            nixvim.nixosModules.nixvim
            sops-nix.nixosModules.sops

            /*
              ══════  Home Manager  ══════
              The configuration is split to keep this flake entry point lean.
            */
            (import ./configs/home-manager/home.nix)

            /*
              ══════  NixOS Configuration Strategy  ══════
              - Base configuration uses streamlined versions of default NixOS modules
              - Host-specific settings are defined in each host's `profile.nix`
              - The modules define default settings shared across hosts, this way we don't repeat
              ourselves and keep `profile.nix` clean an readable.

              This separation of concerns keeps configurations modular and maintainable.
            */
            (import ./configs/nixos/hosts/${hostname}/configuration.nix)
            (import ./configs/nixos/hosts/${hostname}/profile.nix)
            (
              # Dynamically import NixOS modules
              library.moduleImporter {
                dirs = [
                  ./configs/nixos/modules
                ];
              }
            )

            {
              # Overlays - extend nixpkgs with additional or modified packages
              nixpkgs.overlays = [ rust-overlay.overlays.default ];

              # myArgs
              myNixos.myArgsContributions.system = {
                # Make hostname available to all modules via myNixos.myArgsContributions
                hostname = hostname;
              };
            }
          ] ++ hostConfig.extraModules;
        };

      # Hosts definitions
      hosts = {
        chuwi = {
          description = "Headless MiniPC: Intel CPU & GPU, lab + NAS + streaming";
          extraModules = [ ];
          system = "x86_64-linux";
        };
        desktop = {
          description = "Desktop: Intel CPU, Nvidia GPU + KDE";
          extraModules = [ ];
          system = "x86_64-linux";
        };
        perrrkele = {
          description = "Laptop: Intel CPU & GPU + KDE";
          extraModules = [ nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7 ];
          system = "x86_64-linux";
        };
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkHostConfig hosts;
    };
}
