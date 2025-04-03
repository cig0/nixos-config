# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  aliases = {
    dft = "difft --color=always --syntax-highlight=on --skip-unchanged";
  };
in
{
  inherit aliases;
}
