# Home Manager Zsh aliases module. Do not remove this header.
{
  nixosConfig,
  ...
}:
let
  aliases = {
    # Cleaning
    nhcak3 = "nh clean all --keep 3 && nix store optimise --verbose";
    nhcuk3 = "nh clean user --keep 3 && nix store optimise --verbose";
    nixcg3 = "nix-collect-garbage -d 3";

    # Flakes
    nixfc = "nix flake check";

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
