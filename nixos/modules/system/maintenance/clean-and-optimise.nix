{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "nix"] config;
in {
  options.mySystem.nix = {
    settings.auto-optimise-store = lib.mkEnableOption "If set to true, Nix automatically detects files in the store that have
identical contents, and replaces them with hard links to a single copy.
This saves disk space. If set to false (the default), you can still run
nix-store --optimise to get rid of duplicate files.";
    gc.automatic = lib.mkEnableOption "Automatically run the garbage collector at a specific time.";
  };

  config = {
    nix = {
      # Garbage collector. We do the truthiness evaluation at the beginning of the set to avoid polluting the environment with unused non-default options.
      gc = lib.mkIf cfg.gc.automatic {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
        randomizedDelaySec = "720min";
      };

      settings = {
        # Nix store optimisation
        auto-optimise-store = cfg.settings.auto-optimise-store;
      };
    };
  };
}
