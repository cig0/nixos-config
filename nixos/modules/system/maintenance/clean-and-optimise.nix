{ config, lib, ... }:

let
  cfg = {
    auto-optimise-store = config.mySystem.nix.settings.auto-optimise-store;
    gc.automatic = config.mySystem.nix.gc.automatic;
  };

in {
  options.mySystem.nix = {
    settings.auto-optimise-store = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "If set to true, Nix automatically detects files in the store that have
identical contents, and replaces them with hard links to a single copy.
This saves disk space. If set to false (the default), you can still run
nix-store --optimise to get rid of duplicate files.";
    };
    gc.automatic = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Automatically run the garbage collector at a specific time.
";
    };
  };

  config = {
    nix = {
      settings = {  # Nix store optimisation.
        auto-optimise-store = cfg.auto-optimise-store;
      };

      gc = {  # Garbage collector.
        automatic = cfg.gc.automatic;
        dates = "weekly";
        options = "--delete-older-than 7d";
        randomizedDelaySec = "720min";
      };
    };
  };
}