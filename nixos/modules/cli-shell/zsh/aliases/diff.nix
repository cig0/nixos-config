# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    codif = "colordiff -y -W 212";
    d = "delta --paging=never";
    dp = "delta --paging=auto";
    dt = "difft";
  };

in { aliases = aliases; }