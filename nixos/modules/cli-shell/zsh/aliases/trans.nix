# Don't remove this line! programs.zsh.shellAliases

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

in {
  aliases = aliases;
}