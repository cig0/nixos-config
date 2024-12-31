# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Rust's Cargo package manager
  aliases = {
    cargoApps = "$EDITOR ~/.config/Cargo.apps";
  };

in { aliases = aliases; }