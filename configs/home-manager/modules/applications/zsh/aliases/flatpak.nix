# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  aliases = {
    fli = "flatpak install";
    fll = "flatpak list";
    flp = "flatpak ps";
    fls = "flatpak search";
  };
in
{
  inherit aliases;
}
