# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    bt = "btop";
    t = "top";
  };

in { aliases = aliases; }