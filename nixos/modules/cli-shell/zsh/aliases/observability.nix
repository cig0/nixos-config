# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    bt = "btop";
    t = "top";
  };

in { aliases = aliases; }