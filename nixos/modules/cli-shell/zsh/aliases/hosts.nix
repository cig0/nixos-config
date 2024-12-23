# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Hosts
  hosts = {
    sperrrkele = "ssh perrrkele";
    ssatama = "ssh satama";
    sterasbetoni = "ssh terasbetoni";
    skoira = "ssh koira";
    tperrrkele = "ssh perrrkele -t 'tmux attach-session -t'";
    tsatama = "ssh satama -t 'tmux attach-session -t'";
    tterasbetoni = "ssh terasbetoni -t 'tmux attach-session -t'";
    tkoira = "ssh koira -t 'tmux attach-session -t'";
  };

in {
  hosts = hosts;
}