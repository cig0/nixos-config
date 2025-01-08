# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Edit the list of packages managed outside of NixOS.
  aliases = {
    apps-cargo = "$EDITOR ~/.config/apps-cargo";
  };

in { aliases = aliases; }