{ ... }:

{
  imports = [
    ./nh.nix  # Disabled.
    ./nix-settings.nix  # Enabled.
    ./system-auto_upgrade.nix  # Enabled.
  ];
}


# READ ME!
# ========

# Q: Why do I have multiple configurations for system maintenance?
# A: I like to have options. You can choose the one that fits your preferences. Moreover, I want to achieve a modular and dynamic configuration of the flake, that allows to change its behavior at build time by passing the corresponding options.
# I added safety measures to prevent enabling multiple configurations at a time.