# Home Manager Zsh aliases module. Do not remove this header.
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
in
{
  aliases = aliases;
}
