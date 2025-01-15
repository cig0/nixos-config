{
  imports = builtins.filter (x: x != null) [
    ./kde/main.nix
    ./display-manager.nix
    ./firefox.nix
    ./nix-flatpak.nix
    ./ollama.nix
    ./packages.nix
    ./tailscale.nix
    ./xdg-portal.nix
    ./zsh.nix
  ];
}



# READ ME!
# ========

# The NixOS community generally recommends keeping the enabling/disabling logic in the individual module files rather than in the importing module.
# This follows the principle of separation of concerns and makes modules more self-contained.
# Benefits of this approach:
#   - Each module controls its own destiny
#   - Modules are self-contained
#   - Easier to maintain and understand
#   - Follows the NixOS convention of modules managing their own conditional activation
#   - Makes it easier to override in specific cases if needed
#   - This is the more idiomatic NixOS way of handling conditional module activation.