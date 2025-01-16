{ config, inputs, lib, ... }:

let
  cfg = {
    nh.enable = config.mySystem.programs.nh.enable;
    nh.clean.enable = config.mySystem.programs.nh.clean.enable;
  };

in {
  options.mySystem.programs.nh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable nh, yet another Nix CLI helper.";
    };
    clean.enable =lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable periodic garbage collection with nh clean all.";
    };
  };

  config = lib.mkIf (cfg.nh.enable == true) {
    programs.nh = {
      enable = true;
      clean = {
        enable = cfg.nh.clean.enable;
        dates = "weekly";
        extraArgs = "--keep 5";
      };
      flake = inputs.self.outPath;  # Use as input the flake of the current system.
    };
  };
}



# READ ME!
# ========

# nh: Yet another nix cli helper.
# Refs: https://github.com/viperML/nh (don't forget to star it!)

# This configuration is an alternative way to keep a system updated.
# You should have only one updater enabled at a time.