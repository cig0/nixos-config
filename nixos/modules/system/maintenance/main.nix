{
  imports = [
    ./nix-settings.nix  # Garbage collection and Nix store optimization.

    # System upgrade.
      ./nh.nix  # Disabled in favor of NixOS built-in upgrade option.
      ./system-auto_upgrade.nix  # Enabled.
  ];
}



# READ ME!
# ========
# Q: Why do I define two mutually-exclusive ways to update my NixOS systems (nh and NixOS built-in update option)?
# A: I like to have options. You can choose the one that fits your preferences. Moreover, I want to achieve a modular and dynamic configuration of the flake, that allows to change its behavior at build time by passing the corresponding options.
# I added safety measures to prevent enabling multiple configurations at a time.

# CHANGELOG
# =========
# 2025-01-04  Add ./apps-cargo.nix