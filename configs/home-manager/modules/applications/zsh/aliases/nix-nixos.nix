# Home Manager Zsh aliases module. Do not remove this header.
{
  nixosConfig,
  ...
}:
let
  aliases = {
    # Cleaning
    nhc = "nh clean all --keep 3";
    nixc = "nix-collect-garbage -d 3";

    # Flakes
    nixfc = "nix flake check";

    # nh - Yet another nix helper
    nhcak2 = "nh clean all --keep 5";
    nhcuk2 = "nh clean user --keep 5";

    # Search (options and packages)
    nixs = "nix search nixpkgs";
    nixsu = "nix search nixpkgs/nixos-unstable#";
    nhs = "nh search";
    nhsu = "nh search  --channel nixos-unstable";

    # System
    nixinfo = "nix-info --host-os -m";
    nixlg = "nixos-rebuild list-generations";

    # Update NixOS
    nhosb = "nh os boot ${nixosConfig.myNixos.myOptions.flakePath}";
    nhosbd = "nh os boot --dry ${nixosConfig.myNixos.myOptions.flakePath}";
    nhosbu = "nh os boot --update ${nixosConfig.myNixos.myOptions.flakePath}";
    nhosbud = "nh os boot --update --dry ${nixosConfig.myNixos.myOptions.flakePath}";
    nhoss = "nh os switch ${nixosConfig.myNixos.myOptions.flakePath}";
    nhossd = "nh os switch --dry ${nixosConfig.myNixos.myOptions.flakePath}";
    nhossu = "nh os switch --update ${nixosConfig.myNixos.myOptions.flakePath}";
    nhossud = "nh os switch --update --dry ${nixosConfig.myNixos.myOptions.flakePath}";
  };
in
{
  inherit aliases;
}
