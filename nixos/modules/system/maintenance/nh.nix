{ config, inputs, ... }:

let
  # === Assertions ===
    # System upgrade assertions.
    conditionUpgrade1 = config.programs.nh.enable;
    conditionUpgrade2 = config.system.autoUpgrade.enable;

    # Garbage collector assertions.
    conditionGc1 = config.programs.nh.clean.enable;
    conditionGc2 = config.nix.gc.automatic;

in {
  assertions = [
    {
      assertion = !(conditionUpgrade1 && conditionUpgrade2);  # Negated AND condition.
      message = "Error: Both 'programs.nh' and 'system.autoUpgrade' cannot be enabled at the same time.";
    }
    {
      assertion = !(conditionGc1 && conditionGc2);  # Negated AND condition.
      message = "Error: Both 'programs.nh.clean' and 'nix.gc.automatic' cannot be enabled at a time.";
    }
  ];

  programs.nh = {
    flake = inputs.self.outPath;  # Use the flake of the current system.
    clean = {
      enable = false;
      dates = "weekly";
      extraArgs = "--keep 5";
    };
  };
}


# READ ME!
# ========

# nh: Yet another nix cli helper.
# Refs: https://github.com/viperML/nh (don't forget to star it!)

# This configuration is an alternative way to keep a system updated.
# You should have only one updater enabled at a time.

# I added a safety measure to prevent enabling this configuration if `config.system.autoUpgrade` is already enabled.