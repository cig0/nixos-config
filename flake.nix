#------------------------------------------------------------------
# My personal NixOS multi-host configuration flake ¯\_(ツ)_/¯
# https://github.com/cig0/nixos-config
# Initial release on May 1st, 2024
#
# ASCII art credits: https://www.asciiart.eu/
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

    # TODO: To be removed with the release of 25.05 :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-2637395681
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

  outputs =
    {
      auto-cpufreq, # Energy efficiency
      flake-compat, # Make nixos-option work with flakes # TODO: To be removed with the release of 25.05 :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-2637395681
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
      ...
    }@inputs:
    let
      # ░░░░░░░█▀▀░█░█░█▀█░█▀▄░█▀▀░█▀▄░░░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
      # ░░░░░░░▀▀█░█▀█░█▀█░█▀▄░█▀▀░█░█░░░░░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
      # ░░░░░░░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀░░░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░

      nixos-option = import ./nixos/overlays/nixos-option.nix; # TODO: To be removed with the release of 25.05 :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-2637395681

      sharedModules = [
        ./home-manager/home.nix
        ./nixos/modules/default.nix
      ];

      sharedOVerlays = [
        nixos-option # TODO: To be removed with the release of 25.05 :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-2637395681
        rust-overlay.overlays.default
      ];

    in
    {
      # Laptop: Intel CPU & GPU + KDE
      nixosConfigurations = {
        perrrkele =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs system; };
            modules = sharedModules ++ [
              inputs.nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
              ./nixos/hosts/perrrkele/default.nix
              {
                # ░░░░    O V E R L A Y S    ░░░░
                nixpkgs.overlays = sharedOVerlays ++ [ ];
              }
            ];
          };

        # Desktop: Intel CPU, Nvidia GPU
        desktop =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs system; };
            modules = sharedModules ++ [
              ./nixos/hosts/desktop/default.nix
              {
                # ░░░░    O V E R L A Y S    ░░░░
                nixpkgs.overlays = sharedOVerlays ++ [ ];
              }
            ];
          };

        # Headless MiniPC: Intel CPU & GPU, lab + NAS + streaming
        chuwi =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs system; };
            modules = sharedModules ++ [
              ./nixos/hosts/chuwi/default.nix
              {
                # ░░░░    O V E R L A Y S    ░░░░
                nixpkgs.overlays = sharedOVerlays ++ [ ];
              }
            ];
          };
      };
    };
}
