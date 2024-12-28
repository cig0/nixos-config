# Automatic system cleanup and auto-upgrade.

{ config, ... }:

let
  # === Assertions ===
    # Garbage collector assertions.
    conditionGc1 = config.programs.nh.clean.enable;
    conditionGc2 = config.nix.gc.automatic;

in {
  assertions = [
    {
      assertion = !(conditionGc1 && conditionGc2);  # Negated AND condition.
      message = "Error: Both 'programs.nh.clean' and 'nix.gc.automatic' cannot be enabled at a time.";
    }
  ];

  nix = {
    settings = {  # Nix store optimisation.
      auto-optimise-store = true;
    };

    gc = {  # Garbage collector.
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
      randomizedDelaySec = "720min";
    };
  };
}


# READ ME!
# ========

# This configuration is the official way to keep the system in shape.
# You should have only one garbage collector enabled at a time.

# I added a safety measure to prevent enabling this configuration if `nh` is already taking care of the GC.