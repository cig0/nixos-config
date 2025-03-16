# Don't remove this line! This is a NixOS Zsh alias module.
{ ... }:
let
  aliases = {
    # Navigation (CLI)
    e = "exit";
    y = "yazi";

    # Directories shortcuts
    C = "cd ~/workdir/cig0";
    D = "cd ~/Downloads";
    E = "cd ~/Desktop";
    F = "cd ~/workdir/cig0/nixos-config"; # Flake directory.
    Fp = "cd ~/workdir/cig0/nixos/nixos-config-public"; # Public flake.
    N = "cd ~/Notes";
    O = "cd ~/Documents";
    P = "cd ~/Pictures";
    S = "cd ~/Sync";
    T = "cd ~/tmp";
    W = "cd ~/workdir";
    Wcn = "cd ~/workdir/cig0/nixos";
    Wcnp = "cd ~/workdir/cig0/nixpkgs";
  };
in
{
  aliases = aliases;
}
