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
    nhosb = "nh os boot ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace";
    nhosbd = "nh os boot --dry ${nixosConfig.myNixos.myOptions.flakeSrcPath}  -- --show-trace";
    nhosbu = "nh os boot --update ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace";
    nhosbud = "nh os boot --update --dry ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace";
    nhoss = "nh os switch ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace";
    nhossd = "nh os switch --dry ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace";
    nhossu = "nh os switch --update ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace";
    nhossud = "nh os switch --update --dry ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace";
  };
in
{
  inherit aliases;
}
