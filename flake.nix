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
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    auto-cpufreq = {
      # Energy efficiency: https://github.com/AdnanHodzic/auto-cpufreq
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AdnanHodzic/auto-cpufreq";
    };

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

    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixvim = {
      # The intended way to configure Neovim
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-24.11";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    # sops-nix.url = "github:Mic92/sops-nix"; # Secure secrets

    yazi.url = "github:sxyazi/yazi";
  };

  outputs =
    {
      auto-cpufreq, # Energy efficiency
      home-manager, # User-specific settings and packages
      lanzaboote, # Secure Boot for NixOS
      nix-flatpak, # Enhanced Flatpak support
      nix-index, # A files database for nixpkgs
      nix-ld, # Run unpatched dynamic binaries on NixOS
      nixos-cosmic, # COSMIC Desktop Environment
      nixos-hardware, # Additional hardware configuration
      nixpkgs, # NixOS release channel
      nixpkgs-unstable, # NixOS release channel
      nixvim, # A Neovim configuration system for nix
      rust-overlay, # Oxalica's Rust toolchain overlay
      self,
      # sops-nix, # Mic92 NixOS' Mozilla SOPS implementation # TODO: pending implementation.
      yazi, # Blazing fast terminal file manager written in Rust, based on async I/O
      ...
    }@inputs:
    let
      # Create a nixosSystem for each host
      mkHost =
        hostname: hostConfig:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            system = hostConfig.system; # Use the system from the host config
          };
          modules = [
            # Home Manager
            (import ./configs/home-manager/home.nix)
            home-manager.nixosModules.home-manager

            # NixOS
            (import ./configs/nixos/modules/default.nix)
            # Host configuration (dynamic path constructed after the host name)
            (./. + "/configs/nixos/hosts/${hostname}/configuration.nix")

            # Additional configurations
            {
              /*
                ░░░░      O V E R L A Y S      ░░░░
                These overlays are shared across all hosts. If this is not what you want,
                move the desired overlays to the specific host within the extraModules sections"
              */
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
          extraModules = [ ];
        };
        perrrkele = {
          description = "Laptop: Intel CPU & GPU + KDE";
          system = "x86_64-linux";
          extraModules = [ inputs.nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7 ];
        };
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkHost hosts;
    };
}
