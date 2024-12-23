# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  nixos = {
    # Nix and NixOS aliases
      # Cleaning
        nhc = "nh clean all --keep 3";
        nixc = "nix-collect-garbage -d 3";

      # Flakes
        nixfc = "nix flake check";

      # nh - Yet another nix helper
        nhcak5 = "nh clean all --keep 5";
        nhcuk5 = "nh clean user --keep 5";

      # Searching
        nixse = "nix search nixpkgs";
        nixseu = "nix search nixpkgs/nixos-unstable#";
        nhs = "nh search --channel nixos-24.11";

      # System
        nixinfo = "nix-info --host-os -m";
        nixlg = "nixos-rebuild list-generations";

      # Update NixOS
        nhosb = "nh os boot /etc/nixos/nixos-config";
        nhosbd = "nh os boot --dry /etc/nixos/nixos-config";
        nhosbu = "nh os boot --update /etc/nixos/nixos-config";
        nhosbud = "nh os boot --update --dry /etc/nixos/nixos-config";
        nhoss = "nh os switch /etc/nixos/nixos-config";
        nhossd = "nh os switch --dry /etc/nixos/nixos-config";
        nhossu = "nh os switch --update /etc/nixos/nixos-config";
        nhossud = "nh os switch --update --dry /etc/nixos/nixos-config";
  };

in {
  nixos = nixos;
}