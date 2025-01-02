# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    fli = "flatpak install";
    fll = "flatpak list";
    flp = "flatpak ps";
    fls = "flatpak search";
  };

in { aliases = aliases; }