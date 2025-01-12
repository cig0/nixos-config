# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  # Bat - A cat(1) clone with syntax highlighting and Git integration.
  # https://github.com/sharkdp/bat
  aliases = {
    b = "bat --paging=always --style=plain --theme='Dracula' --wrap=auto"; # Plain + paging=always
    bb = " bat --paging=never --style=plain --theme='Dracula' --wrap=auto"; # Plain, no paging
    bnp = "bat --paging=always --style=numbers --theme='Dracula' --wrap=auto"; # Numbers + paging=always
  };

in { aliases = aliases; }