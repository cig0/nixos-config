# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    fll = "flatpak list";
    flp = "flatpak ps";
    fls = "flatpak search";
  };

in {
  aliases = aliases;
}