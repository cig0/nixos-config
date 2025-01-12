# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    journalctl_boot_err = "journalctl -xep err -b";
  };

in { aliases = aliases; }