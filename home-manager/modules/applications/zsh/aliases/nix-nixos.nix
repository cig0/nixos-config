# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    # Cleaning
    nhc = "nh clean all --keep 3";
    nixc = "nix-collect-garbage -d 3";

    # Flakes
    nixfc = "nix flake check";

    # nh - Yet another nix helper
    nhcak5 = "nh clean all --keep 5";
    nhcuk5 = "nh clean user --keep 5";

    # Search (options and packages)
    nixs = "nix search nixpkgs";
    nixsu = "nix search nixpkgs/nixos-unstable#";
    nhs = "nh search";
    nhsu = "nh search  --channel nixos-unstable";

    # System
    nixinfo = "nix-info --host-os -m";
    nixlg = "nixos-rebuild list-generations";

    # Update NixOS
    nhosb = "nh os boot ~/workdir/cig0/nixos-config";
    nhosbd = "nh os boot --dry ~/workdir/cig0/nixos-config";
    nhosbu = "nh os boot --update ~/workdir/cig0/nixos-config";
    nhosbud = "nh os boot --update --dry ~/workdir/cig0/nixos-config";
    nhoss = "nh os switch ~/workdir/cig0/nixos-config";
    nhossd = "nh os switch --dry ~/workdir/cig0/nixos-config";
    nhossu = "nh os switch --update ~/workdir/cig0/nixos-config";
    nhossud = "nh os switch --update --dry ~/workdir/cig0/nixos-config";
  };

in
{
  aliases = aliases;
}
