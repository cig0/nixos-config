# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  # Trans - CLI client for Goolge Translator
  aliases = {
    # English
    tenes = "trans en:es";
    tesen = "trans es:en";
    # Suomi
    tenfi = "trans en:fi";
    tfien = "trans fi:en";
  };

in { aliases = aliases; }