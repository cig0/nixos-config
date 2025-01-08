# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    sTuxedoInfinityBook = "ssh TuxedoInfinityBook";
    ssatama = "ssh satama";
    sterasbetoni = "ssh terasbetoni";
    skoira = "ssh koira";
    tTuxedoInfinityBook = "ssh TuxedoInfinityBook -t 'tmux attach-session -t'";
    tsatama = "ssh satama -t 'tmux attach-session -t'";
    tterasbetoni = "ssh terasbetoni -t 'tmux attach-session -t'";
    tkoira = "ssh koira -t 'tmux attach-session -t'";
  };

in { aliases = aliases; }