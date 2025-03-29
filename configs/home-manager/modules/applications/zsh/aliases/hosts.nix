# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  aliases = {
    sdesktop = "ssh desktop";
    shomelabnas = "ssh homelabnas";
    sperrrkele = "ssh perrrkele";
    sterasbetoni = "ssh terasbetoni";
    tdesktop0 = "ssh desktop -t 'tmux attach-session -t 0'";
    tdesktop = "ssh desktop -t 'tmux attach-session -t'";
    thomelabnas0 = "ssh homelabnas -t 'tmux attach-session -t 0'";
    thomelabnas = "ssh homelabnas -t 'tmux attach-session -t'";
    tperrrkele0 = "ssh perrrkele -t 'tmux attach-session -t 0'";
    tperrrkele = "ssh perrrkele -t 'tmux attach-session -t'";
    tterasbetoni0 = "ssh terasbetoni -t 'tmux attach-session -t 0'";
    tterasbetoni = "ssh terasbetoni -t 'tmux attach-session -t'";
  };
in
{
  aliases = aliases;
}
