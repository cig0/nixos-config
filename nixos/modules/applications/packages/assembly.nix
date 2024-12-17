# Assemble the lists and sets of packages to be installed on a host according to the host's role.

{ config, lib, pkgs, unstablePkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hosts = import ../../../helpers/hostnames.nix { inherit config lib; };

  # Packages to install
  packages = import ./packages.nix { inherit pkgs unstablePkgs; };

  baselinePackages = packages.lists.appsBaseline;

  # Function to create package lists based on host roles
  rolePackages = role:
    baselinePackages ++
    (lib.optionals (role == "Laptop") (
      packages.lists.appsGUI ++
      packages.lists.appsNonGUI
    )) ++
    (lib.optionals (role == "Server") (
      packages.sets.appsNonGUI.infrastructure ++
      packages.sets.appsNonGUI.vcs ++
      [
        pkgs.pinentry-curses
      ]));

  # Build list of packages to be installed on the host
  pkgsList =
    let
      assembly = if hosts.isRoleLaptop then rolePackages "Laptop"
                 else if hosts.isRoleServer then rolePackages "Server"
                 else [];
    in
      assembly ++ lib.optionals hosts.isNvidiaGPUHost packages.lists.appsNvidia;


  #   appsBaseline = packages.lists.appsBaseline;
  #   appsGUI = packages.lists.appsGUI;
  #   appsNonGUI = packages.lists.appsNonGUI;  # Access the whole appsNonGUI list
  #   appsNonGUISets = packages.sets.appsNonGUI;  # Access the entire appsNonGUI set
  #   appsNvidia = packages.lists.appsNvidia;

  # # Build list of packages to be installed on the host
  # pkgsList =
  #   let
  #     pkgsList =
  #       if hosts.isRoleLaptop then
  #         appsBaseline ++
  #         appsGUI ++
  #         appsNonGUI

  #       else if hosts.isRoleServer then
  #         appsBaseline ++
  #         appsNonGUISets.insfrastructure ++
  #         appsNonGUISets.vcs ++
          # [
          #   pkgs.pinentry-curses
          # ]
  #       else [];
  #   in
  #     if hosts.isNvidiaGPUHost then pkgsList ++ appsNvidia
  #     else
  #       pkgsList;

in
{
  imports = builtins.filter (x: x != null) [
    # ./systemPackages-overrides.nix
  ];

  # Allow lincense-burdened packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # =====  systemPackages  =====
  # Install packages system-wide based on the host
  environment.systemPackages = pkgsList;
}
