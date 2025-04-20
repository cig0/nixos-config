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
    nhosb = "ga ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets && nh os boot ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace && grs ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets";
    nhosbd = "ga ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets && nh os boot --dry ${nixosConfig.myNixos.myOptions.flakeSrcPath}  -- --show-trace && grs ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets";
    nhosbu = "ga ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets && nh os boot --update ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace && grs ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets";
    nhosbud = "ga ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets && nh os boot --update --dry ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace && grs ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets";
    nhoss = "ga ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets && nh os switch ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace && grs ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets";
    nhossd = "ga ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets && nh os switch --dry ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace && grs ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets";
    nhossu = "ga ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets && nh os switch --update ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace && grs ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets";
    nhossud = "ga ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets && nh os switch --update --dry ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace && grs ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets";
  };
in
{
  inherit aliases;
}
