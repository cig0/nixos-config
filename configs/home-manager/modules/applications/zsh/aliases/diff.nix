# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  aliases = {
    codif = "colordiff -y -W 212";
    dft = "difft";
  };

in
{
  aliases = aliases;
}
