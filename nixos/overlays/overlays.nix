# Fixes nixos-option not working with flakes :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-1075818028
{ ... }:

{
  nixpkgs.overlays = [
    (import ./nixos-option.nix)
  ];
}