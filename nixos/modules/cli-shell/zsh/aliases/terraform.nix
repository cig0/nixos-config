# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  # Terraform / OpenTofu
  aliases = {
    ot = "opentofu";
    tf = "terraform";
  };

in { aliases = aliases; }