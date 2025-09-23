# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  aliases = {
    ___ = "_h";
    _amnesicShellSession = "unset HISTFILE && history -c && exit";
    _renameDirs = "find -type f -name \"\\$1*\" | xargs renamer --editor nvim"; # pipeline-renamer
    _fi = "find . -maxdepth 1 -iname";
    _t = "tmux -f $HOME/.config/tmux/tmux-zsh.conf new-session -s $(hostnamectl hostname)";
    _terminalColors = "for i in {0..255}; do printf \"\\x1b[38;5;\${i}mcolour\${i}\\x1b[0m\\n\"; done";
    _h = "history | grep -i";
    cp = "cp -i";
    dudir = "du -sh ./"; # Use */ for all dirs in the target directory.
    gi = "grep -i --color=always";
    gir = "grep -ir --color=always";
    glow = "glow --pager -";
    gw = "gwenview";
    ic = "imgcat";
    mv = "mv -i";
    Rm = "/run/current-system/sw/bin/rm";
    rs = "rsync -Pav";
    surs = "sudo rsync -Pav";
    tt = "oathtool --totp -b $(wl-paste -n -p) | wl-copy -n"; # oathtool
    sw3m = "s -b w3m";
    v = "nvim";
  };
in
{
  inherit aliases;
}
