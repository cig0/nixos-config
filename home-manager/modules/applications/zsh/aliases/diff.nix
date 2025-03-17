# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  aliases = {
    codif = "colordiff -y -W 212";
    d = "delta --paging=never";
    dp = "delta --paging=auto";
    dt = "difft";
  };

in
{
  aliases = aliases;
}
