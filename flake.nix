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
      # Import libraries. We need them for the `mkHost` function below.
      lib = inputs.nixpkgs.lib;

      /*
        The mkHost function:
        - Assembles a nixosSystem for each host
        - Makes it easy to share modules, options, and configurations for all hosts
      */
      mkHost =
        hostname: hostConfig:
        let
          system = hostConfig.system;
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            /*
              Import modules from the added flakes.

              Since many of these module options mirror mySystem options (to mask the originalones),
              the final host configuration is assembled using only those options explicitly declared
              in the host's profile.nix module.
            */
            auto-cpufreq.nixosModules.default
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            nix-index-database.nixosModules.nix-index
            nix-flatpak.nixosModules.nix-flatpak
            nix-ld.nixosModules.nix-ld
            nix-snapd.nixosModules.default
            nixvim.nixosModules.nixvim
            sops-nix.nixosModules.sops

            /*
              Dynamically import modules with a plug-and-play approach. Add a new module in the host’s
              config dir or globally in `./configs/nixos/modules`, and it’s auto-imported on the
              next generation. See `./lib/modules.nix` for details.
            */
            (import ./configs/nixos/modules/module-loader.nix)

            /*
              NixOS
              Load host config (dynamic path built from host name). Find custom option toggles in
              `./configs/nixos/hosts/${hostname}/profile.nix`.
            */
            (import ./configs/nixos/hosts/${hostname}/configuration.nix)
            (import ./configs/nixos/hosts/${hostname}/profile.nix)

            /*
              Home Manager
              The configuration is split to keep this flake.nix file slim.
            */
            (import ./configs/home-manager/home.nix)

            {
              # Overlays
              nixpkgs.overlays = [ rust-overlay.overlays.default ];

              # myArgs
              myNixos.myArgsContributions.system = {
                hostname = hostname;
              };
            }
          ] ++ hostConfig.extraModules;
        };

      # Define host-specific configurations here
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
      nixosConfigurations = nixpkgs.lib.mapAttrs mkHost hosts;
    };
}
