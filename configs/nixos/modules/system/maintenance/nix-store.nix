{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.mySystem;
in
{
  options.mySystem = {
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

    # nh: Yet another nix cli helper :: https://github.com/viperML/nh (don't forget to star it!)
    programs.nh = {
      enable = lib.mkEnableOption "Whether to enable nh, yet another Nix CLI helper.";
      clean = {
        enable = lib.mkEnableOption "Whether to enable periodic garbage collection with nh clean all.";
        dates = lib.mkOption {
          type = lib.types.str;
          default = "weekly";
          description = "How often cleanup is performed. Passed to systemd.time";
        };
        extraArgs = lib.mkOption {
          type = lib.types.str;
          default = "--keep 5";
        };
      };
    };
  };

  config = {
    assertions = [
      {
        # assertion = !(config.mySystem.nix.gc.automatic && config.mySystem.programs.nh.enable.clean.enable);
        assertion = !(cfg.nix.gc.automatic && cfg.programs.nh.clean.enable);
        message = "Only one of `mySystem.nix.gc.automatic` or `mySystem.programs.nh.clean.enable` can be enabled at a time.";
      }
    ];

    # Garbage collector. We do the truthiness evaluation at the beginning of the set to avoid polluting the environment with unused non-default options.
    nix = {
      gc = lib.mkIf cfg.nix.gc.automatic {
        automatic = true;
        dates = cfg.nix.gc.dates;
        options = cfg.nix.gc.options;
        randomizedDelaySec = cfg.nix.gc.randomizedDelaySec;
      };
      settings = {
        # Nix store optimisation
        auto-optimise-store = cfg.nix.settings.auto-optimise-store;
      };
    };

    programs.nh = lib.mkIf cfg.programs.nh.enable {
      enable = true;
      flake = inputs.self.outPath;
      clean = {
        enable = cfg.programs.nh.clean.enable;
        dates = cfg.programs.nh.clean.dates;
        extraArgs = cfg.programs.nh.clean.dates;
      };
    };
  };
}
