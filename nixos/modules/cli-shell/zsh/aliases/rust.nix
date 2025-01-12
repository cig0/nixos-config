# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  # Edit the list of packages managed outside of NixOS.
  aliases = {
    apps-cargo = "$EDITOR ~/.config/apps-cargo";
  };

in { aliases = aliases; }