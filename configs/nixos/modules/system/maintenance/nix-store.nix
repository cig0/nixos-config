{
  config,
  lib,
  self,
  ...
}:
{
  options.myNixos = {
    nix = {
      settings.auto-optimise-store = lib.mkEnableOption ''
        If set to true, Nix automatically detects files in the store that have
        identical contents, and replaces them with hard links to a single copy.
        This saves disk space. If set to false (the default), you can still run
        nix-store --optimise to get rid of duplicate files.'';
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
          description = "How often cleanup is performed. Passed to systemd.time.";
        };
        extraArgs = lib.mkOption {
          type = lib.types.str;
          default = "--keep 3";
        };
      };
    };
  };

  config = {
    # Garbage collector. We do the truthiness evaluation at the beginning of the set to avoid polluting the environment with unused non-default options.
    nix = {
      gc = lib.mkIf config.myNixos.nix.gc.automatic {
        automatic = true;
        dates = config.myNixos.nix.gc.dates;
        options = config.myNixos.nix.gc.options;
        randomizedDelaySec = config.myNixos.nix.gc.randomizedDelaySec;
      };
      settings = {
        # Nix store optimisation
        auto-optimise-store = config.myNixos.nix.settings.auto-optimise-store;
      };
    };

    programs.nh = lib.mkIf config.myNixos.programs.nh.enable {
      enable = true;
      flake = self.outPath;
      clean = {
        enable = config.myNixos.programs.nh.clean.enable;
        dates = config.myNixos.programs.nh.clean.dates;
        extraArgs = config.myNixos.programs.nh.clean.dates;
      };
    };
  };
}
