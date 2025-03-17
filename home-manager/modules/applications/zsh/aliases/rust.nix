# Home Manager Zsh aliases module. Do not remove this header.

{ ... }:

let
  # Edit the list of packages managed outside of NixOS.
  aliases = {
    apps-cargo = "$EDITOR ~/.config/apps-cargo";
  };

in { aliases = aliases; }