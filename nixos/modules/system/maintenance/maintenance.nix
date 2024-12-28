{ ... }:

{
  imports = [
    ./modules/nh.nix  # Disabled.
    ./modules/nix-settings.nix  # Enabled.
    ./modules/system-auto_upgrade.nix  # Enabled.
  ];
}


# READ ME!
# ========

# Q: Why do I have multiple configurations for system maintenance?
# A: I like to have options. You can choose the one that fits your needs. Moreover, I want to achieve a modular and dynamic configuration of the flake, that allows to change it behavior at build time by passing the corresponding options.
# I added safety measures to prevent enabling multiple configurations at a time.