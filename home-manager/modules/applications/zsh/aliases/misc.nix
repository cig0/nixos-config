# Don't remove this line! This is a NixOS Zsh alias module.
{...}: let
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
    mv = "mv -i";
    Rm = "/run/current-system/sw/bin/rm";
    rs = "rsync -Pav";
    surs = "sudo rsync -Pav";
    tt = "oathtool --totp -b $(wl-paste -n -p) | wl-copy -n";
    sw3m = "s -b w3m";
    v = "nvim";
  };
in {aliases = aliases;}
