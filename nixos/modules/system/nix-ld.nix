{
  # https://github.com/nix-community/nix-ld
  # (Enabled wih the flake) The module in this repository defines a new module under (programs.nix-ld.dev) instead of (programs.nix-ld) to not collide with the nixpkgs version.
  programs.nix-ld.enable = true;
  programs.nix-ld.dev.enable = false;
}