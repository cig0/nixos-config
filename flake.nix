/*
  ------------------------------------------------------------------
  My personal NixOS multi-host configuration flake ¯\_(ツ)_/¯
  https://github.com/cig0/nixos-config
  Kickoff commit on May 29th 2024, 4:20 AM.
  Initial public release on ${TBD}.

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
    nixpkgs.url = "nixpkgs/nixos-24.11"; # NixOS release channel
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # The unstable release channel to allow for fresher packages

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs"; # Optional, not necessary for the module
    agenix.inputs.darwin.follows = ""; # Optionally choose not to download darwin deps (saves some resources on Linux)

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
      # sops-nix, # TODO: pending implementation. I need to compare it with Agenix and decide which one to use.
      yazi,
      ...
    }@inputs:
    let
      # Import libraries. We need them for the `mkHost` function below.
      lib = inputs.nixpkgs.lib;

      /*
        The mkHost function:
        - Assembles a nixosSystem for each host.
        - Makes it easy to share modules, options, and configurations for all hosts.
      */
      mkHost =
        hostname: hostConfig:
        let
          /*
            We will use the CPU architecture declared in hardware-configuration.nix,
            created by `nixos-generate-config` (and originally provided by the NixOS installer),
            to determine the system architecture.

            The path to hardware-configuration.nix is constructed after the host name dynamically,
            so we can use a single function for all hosts.

            With this approach we:
            - Drastically reducec manual intervention when adding new hosts
            - Avoid redundancy in the configuration (DRY principle)
            - Avoid hardcoding the architecture for each host

            Because we are limited in what we can do here, we parse the file for the
            string `nixpkgs.hostPlatform` and extract the value from the line.

            Given that `system` is a local variable, we need to inherit it and pass it to the
             modules using specialArgs.
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
            # Import modules from the added flakes
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
              Home Manager
              - The configuration is split to keep this flake.nix file slim
            */
            (import ./configs/home-manager/home.nix)

            /*
              NixOS
              - Load host configuration (dynamic path constructed after the host name).
                Find the host custom option toggles in `./configs/nixos/hosts/${hostname}/profile.nix`.
              - Dynamically load modules with a plug-and-play approach.
                Just drop a new module within the host's configuration directory or globally in
                `./configs/nixos/modules`, and it should be automatically imported next time you create
                a new generation. Check `./lib/modules.nix` for more details.
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
          description = "Desktop: Intel CPU, Nvidia GPU + KDE";
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
