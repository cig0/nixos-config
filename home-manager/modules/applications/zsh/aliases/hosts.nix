# Don't remove this line! This is a NixOS Zsh alias module.
{...}: let
  aliases = {
    sTUXEDOInfinityBookPro = "ssh TUXEDOInfinityBookPro";
    shomelabnas = "ssh homelabnas";
    sterasbetoni = "ssh terasbetoni";
    sdesktop = "ssh desktop";
    tTUXEDOInfinityBookPro = "ssh TUXEDOInfinityBookPro -t 'tmux attach-session -t'";
    thomelabnas = "ssh homelabnas -t 'tmux attach-session -t'";
    tterasbetoni = "ssh terasbetoni -t 'tmux attach-session -t'";
    tdesktop = "ssh desktop -t 'tmux attach-session -t'";
  };
in {aliases = aliases;}
