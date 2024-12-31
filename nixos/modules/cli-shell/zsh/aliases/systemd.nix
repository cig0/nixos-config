# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    journalctl_boot_err = "journalctl -xep err -b";
  };

in { aliases = aliases; }