{ config, inputs, ... }:

let
  # === Assertions ===
  conditionUpgrade1 = config.programs.nh.enable;
  conditionUpgrade2 = config.system.autoUpgrade.enable;

in {
  assertions = [
    {
      assertion = !(conditionUpgrade1 && conditionUpgrade2);  # Negated AND condition.
      message = "Error: Both 'programs.nh' and 'system.autoUpgrade' cannot be enabled at the same time.";
    }
  ];

  system.autoUpgrade = {
    # Since NixOS 24.05, you can also use the awesome `nh` helper tool, which I use extensibly on-demand.
    # Refs: https://search.nixos.org/options?query=nh
    enable = true;
    allowReboot = false;
    dates = "daily";
    flags = [
      "--commit-lock-file"
      "--no-build-nix"
      "--print-build-logs"
    ];
    flake = inputs.self.outPath;  # Use the flake of the current system.
    operation = "boot";
    randomizedDelaySec = "720min";
    persistent = false;  # Do not try to upgrade early to compensate a missed reboot
  };
}


# READ ME!
# ========

# This configuration is the official way to keep a system updated.
# I allow only one updater enabled at a time.

# I added a safety measure to prevent enabling this configuration if `programs.nh` is already enabled.

# TODO
# [ ] Add a systemd-timer to periodically update the Cargo packages: nixos/modules/cli-shell/zsh/functions/cargo.nix