# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    codif = "colordiff -y -W 212";
    d = "delta --paging=never";
    dp = "delta --paging=auto";
    dt = "difft";
  };

in { aliases = aliases; }