# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    # Google Gemini
    aG = "aichat -m gemini";
    aGc = "aichat -m gemini --code";
    aGl = "aichat -m gemini --list-sessions";
    aGs = "aichat -m gemini --session";
  };

in { aliases = aliases; }