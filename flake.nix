/*
  ---------------------------------------------------------------------------
  My personal NixOS multi-host & multi-channel configuration flake ¯\_(ツ)_/¯
  https://github.com/cig0/nixos-config
  Kickoff commit on May 29th 2024, 4:20 AM.

  ASCII art credits: https://www.asciiart.eu/cartoons/beavis-and-butt-head
  ---------------------------------------------------------------------------


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
  Flake Strategy
  --------------

  NixOS Configuration:
  - Base configuration implements NixOS modules with default values for all hosts
  - Host-specific options as well as module override options are defined in each host's
  `profile.nix` module
  - The module `configuration.nix` handles core system setup (as in a fresh NixOS installation)

  Home Manager Configuration:
  - The HM entry point is the module `configs/home-manager/home.nix`
  - The module `home.nix` has the dynamic modules loader invocation

  This separation of concerns keeps configurations modular and maintainable.
*/
{
  description = "cig0's NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05"; # NixOS release channel
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # The unstable release channel to allow for fresher packages

    # age-encrypted secrets for NixOS
    agenix.url = "github:ryantm/agenix";
    agenix-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:ryantm/agenix";
    };

    # Energy efficiency for battery-powered devices
    auto-cpufreq = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AdnanHodzic/auto-cpufreq";
    };
    auto-cpufreq-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:AdnanHodzic/auto-cpufreq";
    };

    # # Determinate is an end-to-end toolchain for using Nix
    # determinate = {
    #   inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    #   url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    # };

    clan-core = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://git.clan.lol/clan/clan-core";
    };
    clan-core-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "git+https://git.clan.lol/clan/clan-core";
    };

    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko/latest";
    };
    disko-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/disko";
    };

    flake-compat = {
      url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    };
    flake-compat-unstable = {
      url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    };

    # Home Manager: user-specific packages and settings
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager?ref=release-25.05";
    };
    home-manager-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/home-manager"; # Track the master branch
    };

    # Secure Boot for NixOS
    lanzaboote = {
      inputs.nixpkgs.follows = "nixpkgs"; # Optional but recommended to limit the size of the system closure
      url = "github:nix-community/lanzaboote/v0.4.2";
    };
    lanzaboote-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/lanzaboote";
    };

    # A plug-and-play module management framework for NixOS flakes
    modulon = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cig0/modulon/v0.1.1";
      # url = "github:cig0/modulon/?ref="; # Test new functionality by pulling from branches
    };
    modulon-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:cig0/modulon";
    };

    nix-apple-fonts = {
      url = "github:pinpox/nix-apple-fonts";
      inputs.flake-compat.follows = "flake-compat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-apple-fonts-unstable = {
      url = "github:pinpox/nix-apple-fonts";
      inputs.flake-compat.follows = "flake-compat";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Declarative Flatpak management for NixOS
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
    nix-flatpak-unstable = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    # Weekly updated nix-index database for nixos-unstable channel
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/nix-index-database";
    };
    nix-index-database-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/nix-index-database";
    };

    # Run unpatched dynamic binaries on NixOS
    nix-ld = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:Mic92/nix-ld";
    };
    nix-ld-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:Mic92/nix-ld";
    };

    # Additional hardware configurations
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    nixos-hardware-unstable = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # Snapd support for NixOS
    nix-snapd = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/nix-snapd";
    };
    nix-snapd-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/nix-snapd";
    };

    # A Neovim configuration system for Nix
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim/nixos-25.05";
    };
    nixvim-unstable = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/nixvim";
    };

    plymouth-is-underrated = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cig0/plymouth-is-underrated-cab404";
    };

    # Oxalica's Rust toolchain overlay
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    /*
      Keep only globally used inputs in this signature. Inputs tied to specific functionalities
      are referenced directly in their respective modules, avoiding unnecessary declarations here.
    */
    {
      nixpkgs,
      nixpkgs-unstable,
      self,
      ...
    }@inputs:
    let
      # Import external libraries
      mkLibrary = system: {
        ansiColors = import "${self}/lib/ansi-colors" { };
        modulon = inputs.modulon.lib.${system};
      };

      mkHostConfig =
        /*
           - Creates a NixOS system configuration for each host
           - Applies common modules, configurations, and (optionally) Home Manager as a module
           across all hosts
           - Incorporates host-specific settings from individual host profiles
           - Enables dynamic module loading thanks to Modulon for easy extensibility
        */
        hostname: hostConfig:
        let
          library = mkLibrary hostConfig.system;
          libAnsiColors = library.ansiColors;
          libModulon = library.modulon;
          system = hostConfig.system;

          channelMap = {
            /*
              Each channel (stable/unstable) defines its nixpkgs source and a set of filtered,
              normalized third-party inputs via _inputs, which is constructed by
              buildChannelInputsSet to handle channel-specific suffix stripping.
            */
            stable = {
              _inputs = buildChannelInputsSet "stable";
              p = nixpkgs;
            };
            unstable = {
              _inputs = buildChannelInputsSet "stable";
              p = nixpkgs-unstable;
            };
          };

          releaseChannel = channelMap.${hostConfig.channel};

          # Function to build a set of third-party inputs based on channel context
          buildChannelInputsSet =
            channel:
            let
              # Filter inputs based on channel: unstable gets only -unstable suffixed inputs,
              # stable gets all others (including -stable or no suffix)
              inputsByChannel = releaseChannel.p.lib.filterAttrs (
                name: _:
                if channel == "unstable" then
                  releaseChannel.p.lib.hasSuffix "-unstable" name
                else
                  !releaseChannel.p.lib.hasSuffix "-unstable" name
              ) inputs;

              # Include channel-agnostic inputs (those without any suffix) in both channels
              agnosticInputs = releaseChannel.p.lib.filterAttrs (
                name: _:
                !releaseChannel.p.lib.hasSuffix "-unstable" name && !releaseChannel.p.lib.hasSuffix "-stable" name
              ) inputs;

              # Combine filtered inputs with agnostic ones for the appropriate channel
              combinedInputs =
                if channel == "unstable" then agnosticInputs // inputsByChannel else inputsByChannel;

              inputsBaseNames = releaseChannel.p.lib.mapAttrs' (name: value: {
                /*
                  Create clean base names by removing channel suffixes for consistent referencing
                  in modules; unstable removes -unstable, stable removes -stable if present,
                  otherwise keeps original name, ensuring normalized names for imports
                */
                name =
                  if channel == "unstable" then
                    releaseChannel.p.lib.removeSuffix "-unstable" name
                  else if releaseChannel.p.lib.hasSuffix "-stable" name then
                    releaseChannel.p.lib.removeSuffix "-stable" name
                  else
                    name;
                inherit value;
              }) combinedInputs;
            in
            inputsBaseNames;
        in
        releaseChannel.p.lib.nixosSystem {
          inherit system;

          specialArgs = {
            /*
              Pass additional arguments to modules; _inputs provides direct access to
              the normalized set of channel-specific inputs, allowing reference via
              _inputs.<normalizedName> (e.g., _inputs.home-manager) in any module.
              Raw inputs are not included here to avoid redundancy, but can be accessed directly
              via 'inputs' within mkHostConfig if needed for edge cases.
            */
            inherit
              libAnsiColors
              libModulon
              nixpkgs-unstable
              self
              system
              ;
            _inputs = releaseChannel._inputs;
          };

          modules = [
            # releaseChannel._inputs.determinate.nixosModules.default
            releaseChannel._inputs.home-manager.nixosModules.home-manager
            releaseChannel._inputs.nix-index-database.nixosModules.nix-index
            releaseChannel._inputs.nix-snapd.nixosModules.default

            /*
              ══════  Home Manager  ══════
              The configuration is split to keep this flake file lean.
            */
            "${self}/configs/home-manager/home.nix"

            /*
              ══════  NixOS Configuration Strategy  ══════
              - Host-specific settings are defined in each host's `profile.nix` module.
              - The modules define default settings common to all hosts; this way, we don't repeat
              ourselves and keep the `profile.nix` module clean an readable.
              -

              This separation of concerns keeps configurations modular and maintainable.
            */
            "${self}/configs/nixos/hosts/${hostname}/configuration.nix"
            "${self}/configs/nixos/hosts/${hostname}/profile.nix"

            # Dynamically import NixOS modules
            (libModulon { dirs = [ "${self}/configs/nixos/modules" ]; })

            {
              # Make variables available to all modules via myArgs
              myNixos.myArgsContributions.system = {
                inherit hostname;
              };
            }
          ] ++ hostConfig.extraModules;
        };

      hosts = {
        /*
          ══════  Hosts definitions  ══════
          channel: Nixpkgs channel to use (stable/unstable). Home Manager, if enabled, follows the
          same channel, too. This allows for a tight integration between NixOS and HM avoiding
          potential mismatch issues between NixOS and Home Manager versions.
          For the unstable channel, ensure that the home-manager-unstable input and output are set!
        */
        chuwi = {
          description = "Headless MiniPC: Intel CPU & GPU, lab + NAS + streaming";
          channel = "stable";
          system = "x86_64-linux";
          extraModules = [ ];
        };
        desktop = {
          description = "Desktop: Intel CPU, Nvidia GPU + KDE";
          channel = "stable";
          system = "x86_64-linux";
          extraModules = [ ];
        };
        tuxedo = {
          description = "Laptop: Intel CPU & GPU + KDE";
          channel = "stable";
          system = "x86_64-linux";
          extraModules = [ inputs.nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7 ];
        };
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs mkHostConfig hosts;
    };
}
