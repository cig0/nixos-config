# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Flatpak
  flatpak = {
    fll = "flatpak list";
    flp = "flatpak ps";
    fls = "flatpak search";
  };

in {
  flatpak = flatpak;
}