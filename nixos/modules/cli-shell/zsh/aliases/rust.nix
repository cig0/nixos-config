# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Rust's Cargo package manager
  rust = {
    cargoApps = "$EDITOR ~/.config/Cargo.apps";
  };

in {
  rust = rust;
}