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

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs"; # optional, not necessary for the module
    agenix.inputs.darwin.follows = ""; # optionally choose not to download darwin deps (saves some resources on Linux)

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
      agenix,
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
      # Import libraries. We need them for the `mkHost` function.
      lib = inputs.nixpkgs.lib;

      /*
        mkHost function:
        - Assemble a nixosSystem for each host.
        - Shared host settings should live here.
      */
      mkHost =
        hostname: hostConfig:
        let
          /*
            We will use the CPU architecture declared in hardware-configuration.nix,
            created by `nixos-generate-config` (and originally provided by the NixOS installer).

            The path is constructed after the host name dynamically, so we can have a single
            function for all hosts.

            With this approach we avoid:
            - Manual intervention when adding new hosts
            - Redundancy in the configuration (DRY principle)
            - Hardcoding the architecture for each host

            Because we are limited in what we can do here, we parse the file for the
            string `nixpkgs.hostPlatform` and extract the value from the line.

            Because `system` is a local variable, we need to later inherit it and pass it to specialArgs.
          */
          hwConfigText = builtins.readFile (
            ./. + "/configs/nixos/hosts/${hostname}/hardware-configuration.nix"
          );

          lines = lib.splitString "\n" hwConfigText;
          platformLine = lib.findFirst (line: lib.hasInfix "nixpkgs.hostPlatform" line) "" lines;

          system =
            if platformLine != "" then
              lib.elemAt (lib.splitString "\"" (lib.elemAt (lib.splitString "=" platformLine) 1)) 1
            else
              "x86_64-linux"; # Fallback architecture
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            # Import modules from flakes
            agenix.nixosModules.default
            auto-cpufreq.nixosModules.default
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            nix-index-database.nixosModules.nix-index
            nix-flatpak.nixosModules.nix-flatpak
            nix-ld.nixosModules.nix-ld
            nix-snapd.nixosModules.default
            nixvim.nixosModules.nixvim

            /*
              Home Manager:
              - The configuration is split to keep this flake.nix file slim
              - A module (in the list above) is imported from the flake
            */
            (import ./configs/home-manager/home.nix)

            /*
              NixOS modules:
              - Load host configuration (dynamic path constructed after the host name)
              - Dynamically load modules with a plug-and-play approach. Just drop a new module
                within the host's configuration directory or globally in `configs/nixos/modules`,
                and it will be automatically imported next time you create a new generation.
            */
            (./. + "/configs/nixos/hosts/${hostname}/configuration.nix")
            (import ./configs/nixos/modules/default.nix)

            {
              # Overlays
              nixpkgs.overlays = [
                rust-overlay.overlays.default
              ];
            }
          ] ++ hostConfig.extraModules;
        };

      # Define host-specific configurations here
      hosts = {
        chuwi = {
          description = "Headless MiniPC: Intel CPU & GPU, lab + NAS + streaming";
          extraModules = [ ];
        };
        desktop = {
          description = "Desktop: Intel CPU, Nvidia GPU";
          extraModules = [ ];
        };
        perrrkele = {
          description = "Laptop: Intel CPU & GPU + KDE";
          extraModules = [
            nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
          ];
        };
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkHost hosts;
    };
}
