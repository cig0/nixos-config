# Don't remove this line! This is a NixOS Zsh alias module.
{ ... }:
let
  aliases = {
    # Navigation (CLI)
    e = "exit";
    o = "ranger";
    y = "yazi";

    # Directories shortcuts
    D = "cd ~/Downloads";
    Da = "cd ~/data";
    Darr = "cd /run/media/data";
    E = "cd ~/Desktop";
    F = "cd /etc/nixos/nixos-config"; # Flake directory.
    Ff = "cd ~/workdir/cig0/nixos/nixos-config-public"; # Public flake.
    N = "cd ~/Notes";
    O = "cd ~/Documents";
    P = "cd ~/Pictures";
    S = "cd ~/Sync";
    T = "cd ~/tmp";
    W = "cd ~/workdir";
    Wc = "cd ~/workdir/cig0";
    Wcn = "cd ~/workdir/cig0/nixos";
    Wcnp = "cd ~/workdir/cig0/nixpkgs";
  };
in
{
  aliases = aliases;
}
