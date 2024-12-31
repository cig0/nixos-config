# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Terraform / OpenTofu
  aliases = {
    ot = "opentofu";
    tf = "terraform";
  };

in { aliases = aliases; }