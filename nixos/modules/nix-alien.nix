# TODO: legacy code, most likely. Review before enabling this module.

{ ... }:

let
  nix-alien-pkgs = import (
    builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master"
  ) { };
in
  {
    environment.systemPackages = with nix-alien-pkgs; [
      nix-alien
    ];

    # Optional, but this is needed for `nix-alien-ld` command
    # Run unpatched dynamic binaries on NixOS. :: https://github.com/Mic92/nix-ld
    programs.nix-ld.enable = true;
  }
