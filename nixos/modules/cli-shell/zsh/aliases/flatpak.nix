# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    fli = "flatpak install";
    fll = "flatpak list";
    flp = "flatpak ps";
    fls = "flatpak search";
  };

in { aliases = aliases; }