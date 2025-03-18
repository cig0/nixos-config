# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  aliases = {
    l = "ls -lh --group-directories-first";
    l1 = "ls -1 --group-directories-first";
    l11 = "ls -1rt";
    ldir = "ls -dl */ --color=always --group-directories-first";
    ll = "ls -1rt";
    lla = "ls -lAh --group-directories-first";
    lm = "ls -lrt --color=always";
    lma = "ls -lartA --color=always";
    lsa = "ls -a --color=always --group-directories-first";
    lsrt = "ls -rt";
  };
in
{
  aliases = aliases;
}
