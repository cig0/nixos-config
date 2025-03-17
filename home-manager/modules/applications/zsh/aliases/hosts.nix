# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  aliases = {
    sperrrkele = "ssh perrrkele";
    shomelabnas = "ssh homelabnas";
    sterasbetoni = "ssh terasbetoni";
    sdesktop = "ssh desktop";
    tperrrkele = "ssh perrrkele -t 'tmux attach-session -t'";
    thomelabnas = "ssh homelabnas -t 'tmux attach-session -t'";
    tterasbetoni = "ssh terasbetoni -t 'tmux attach-session -t'";
    tdesktop = "ssh desktop -t 'tmux attach-session -t'";
  };
in
{
  aliases = aliases;
}
