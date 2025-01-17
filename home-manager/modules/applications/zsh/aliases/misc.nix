# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    _h = "history | grep -i";
    ___ = "_h";
    _fi = "find . -maxdepth 1 -iname";
    _t = "tmux -f $HOME/.config/tmux/tmux-zsh.conf new-session -s $(hostnamectl hostname)";
    cp = "cp -i";
    dudir = "du -sh ./"; # Use */ for all dirs in the target directory.
    g = "gwenview";
    gi = "grep -i --color=always";
    glow = "glow --pager -";
    ic = "imgcat";
    memusage="ps -eo comm,%mem,rss --sort=comm | awk 'NR > 1 {a[\$1]+=\$2; b[\$1]+=\$3} END {for (i in a) printf \"%-20s %5.2f%% %10.2f MB\n\", i, a[i], b[i]/1024}' | sort -k2 -nr | head -n 20";
    mv = "mv -i";
    rs = "rsync -Pav";
    surs = "sudo rsync -Pav";
    tt = "oathtool --totp -b $(wl-paste -n -p) | wl-copy -n";
    sw3m = "s -b w3m";
    v = "nvim";
  };

in { aliases = aliases; }