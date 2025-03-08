{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.mySystem.myOptions.nix-store-maintenance;
in
{
  options.mySystem = {
    myOptions = {
      nix-store-maintenance = {
        nix = {
          settings.auto-optimise-store = lib.mkEnableOption "If set to true, Nix automatically detects files in the store that have
identical contents, and replaces them with hard links to a single copy.
This saves disk space. If set to false (the default), you can still run
nix-store --optimise to get rid of duplicate files.";
          gc = {
            automatic = lib.mkEnableOption "Automatically run the garbage collector at a specific time.";
            dates = lib.mkOption {
              type = lib.types.str;
              default = "weekly";
              description = "The time at which the garbage collector should run. Possible values are 'daily', 'weekly', 'monthly', 'never'.";
            };
            options = lib.mkOption {
              type = lib.types.str;
              default = "--delete-older-than 7d";
              description = "Options to pass to the garbage collector.";
            };
            randomizedDelaySec = lib.mkOption {
              type = lib.types.str;
              default = "720min";
              description = "Randomized delay in seconds before running the garbage collector.";
            };
          };
        };
        programs.nh = {
          enable = lib.mkEnableOption "Whether to enable nh, yet another Nix CLI helper.";
          clean.enable = lib.mkEnableOption "Whether to enable periodic garbage collection with nh clean all.";
        };
      };

      config = {
        nix = {
          # Garbage collector. We do the truthiness evaluation at the beginning of the set to avoid polluting the environment with unused non-default options.
          gc = lib.mkIf cfg.gc.automatic {
            automatic = true;
            dates = cfg.gc.dates;
            options = cfg.gc.options;
            randomizedDelaySec = cfg.nix.gc.randomizedDelaySec;
          };

          settings = {
            # Nix store optimisation
            auto-optimise-store = cfg.settings.auto-optimise-store;
          };
        };
      };
    };
  };
}

#   options.mySystem.programs.nh = {
#     enable = lib.mkEnableOption "Whether to enable nh, yet another Nix CLI helper.";
#     clean.enable = lib.mkEnableOption "Whether to enable periodic garbage collection with nh clean all.";
#   };

#   config = lib.mkIf cfg.enable {
#     programs.nh = {
#       enable = true;

#       # TODO: check config.nix.gc.enable = false;
#       clean = lib.mkIf cfg.clean.enable {
#         enable = true;
#         dates = "weekly";
#         extraArgs = "--keep 5";
#       };
#       flake = inputs.self.outPath; # Use as input the flake of the current system.
#     };
#   };
# }
# # READ ME!
# # ========
# # nh: Yet another nix cli helper.
# # Refs: https://github.com/viperML/nh (don't forget to star it!)
# # This configuration is an alternative way to keep a system updated.
# # You should have only one updater enabled at a time.
