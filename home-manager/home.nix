# TODO: this is a template
# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module

{ config, ... }:

{
  programs.home-manager.enable = true;

  # Optionally, use home-manager.extraSpecialArgs to pass
  # arguments to home.nix
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.cig0 = { ... }: {
      home.packages = [ ];

      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "23.11";
    };
  };
}