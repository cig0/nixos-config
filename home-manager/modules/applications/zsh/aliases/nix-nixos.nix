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
    nhosb = "nh os boot ${nixosConfig.mySystem.myOptions.nixos.flake.path}";
    nhosbd = "nh os boot --dry ${nixosConfig.mySystem.myOptions.nixos.flake.path}";
    nhosbu = "nh os boot --update ${nixosConfig.mySystem.myOptions.nixos.flake.path}";
    nhosbud = "nh os boot --update --dry ${nixosConfig.mySystem.myOptions.nixos.flake.path}";
    nhoss = "nh os switch ${nixosConfig.mySystem.myOptions.nixos.flake.path}";
    nhossd = "nh os switch --dry ${nixosConfig.mySystem.myOptions.nixos.flake.path}";
    nhossu = "nh os switch --update ${nixosConfig.mySystem.myOptions.nixos.flake.path}";
    nhossud = "nh os switch --update --dry ${nixosConfig.mySystem.myOptions.nixos.flake.path}";
  };
in
{
  aliases = aliases;
}
