/*
  ------------------------------------------------------------------
   My personal NixOS multi-host configuration flake ¯\_(ツ)_/¯
   https://github.com/cig0/nixos-config
   Initial release on May 1st, 2024

   ASCII art credits: https://www.asciiart.eu/
  ------------------------------------------------------------------
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
{
  description = "cig0's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11"; # Main NixOS release channel followed by the flake
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # The unstable NixOS release channel to allow for fresher packages

    # Energy efficiency for battery-powered devices
    auto-cpufreq = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AdnanHodzic/auto-cpufreq";
    };

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

    # A files database for nixpkgs(-unstable)
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

    # A Neovim configuration system for nix
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-24.11";
    };

    # Oxalica's Rust toolchain overlay
    rust-overlay.url = "github:oxalica/rust-overlay";

    # Secure secrets
    # sops-nix.url = "github:Mic92/sops-nix";

    # Blazing fast terminal file manager written in Rust, based on async I/O
    yazi.url = "github:sxyazi/yazi";
  };

  outputs =
    {
      auto-cpufreq,
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
      rust-overlay,
      self,
      # sops-nix, # TODO: pending implementation.
      yazi,
      ...
    }@inputs:
    let
      mkHost =
        /*
          Create a nixosSystem for each host.
          Settings common to all hosts should live here.
        */
        hostname: hostConfig:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            system = hostConfig.system; # Use the system architecture defined by each host configuration
          };
          modules = [
            # Modules from flakes
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            nix-index-database.nixosModules.nix-index
            nix-ld.nixosModules.nix-ld
            nix-snapd.nixosModules.default
            nixvim.nixosModules.nixvim

            # Home Manager
            (import ./configs/home-manager/home.nix) # Configuration declared separately to keep flake.nix slim

            # NixOS setup
            (import ./configs/nixos/modules/default.nix) # Dynamically load NixOS modules
            (./. + "/configs/nixos/hosts/${hostname}/configuration.nix") # Load host configuration (dynamic path constructed after the host name)

            {
              # Overlays
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
            }
          ] ++ hostConfig.extraModules;
        };

      # Define host-specific configurations
      hosts = {
        chuwi = {
          description = "Headless MiniPC: Intel CPU & GPU, lab + NAS + streaming";
          system = "x86_64-linux";
          extraModules = [ ];
        };
        desktop = {
          description = "Desktop: Intel CPU, Nvidia GPU";
          system = "x86_64-linux";
          extraModules = [ nix-flatpak.nixosModules.nix-flatpak ];
        };
        perrrkele = {
          description = "Laptop: Intel CPU & GPU + KDE";
          system = "x86_64-linux";
          extraModules = [
            auto-cpufreq.nixosModules.default
            nix-flatpak.nixosModules.nix-flatpak
            nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
          ];
        };
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkHost hosts;
    };
}
