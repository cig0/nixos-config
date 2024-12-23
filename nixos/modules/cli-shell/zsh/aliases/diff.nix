# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  diff = {
    codif = "colordiff -y -W 212";
    d = "delta --paging=never";
    dp = "delta --paging=auto";
    dt = "difft";
  };

in {
  diff = diff;
}