# assemble.nix
# This file assembles the lists of packages to be installed on a host according to the host's role.

{ config, lib, pkgs, unstablePkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hosts = import ../../../helpers/hostnames.nix { inherit config lib; };

  # Packages Lists
  packages = import ./packages.nix { inherit pkgs unstablePkgs; };
    appsBaselineSet = packages.sets.appsBaseline;
    appsNonGUISet = packages.sets.appsNonGUI;
    appsGUISet = packages.sets.appsGUI;
    appsNvidiaSet = packages.sets.appsNvidia;

  # Build list of packages to be installed on the host
  pkgsList =
    let
      appsBaselineList = builtins.concatLists (builtins.attrValues appsBaselineSet);
      appsNonGUIList = builtins.concatLists (builtins.attrValues appsNonGUISet);
      appsGUIList = builtins.concatLists (builtins.attrValues appsGUISet);
      appsNvidiaList = builtins.concatLists (builtins.attrValues appsNvidiaSet);

      pkgsList =
        if hosts.isRoleLaptop then
          appsBaselineList ++
          appsNonGUIList ++
          appsGUIList

        else if hosts.isRoleServer then
          appsBaselineList ++
          appsNonGUIList ++
          [
            pkgs.pinentry-curses
          ]
        else [];
    in
      if hosts.isNvidiaGPUHost then pkgsList ++ appsNvidiaList
      else
        pkgsList;

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
