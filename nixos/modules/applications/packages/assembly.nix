# assemble.nix
# This file assembles the lists of packages to be installed on a host according to the host's role.


{ config, lib, pkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hosts = import ../../helpers/hostnames.nix { inherit config lib; };

  # Packages Lists
  packages = import ../applications/packages.nix { inherit pkgs; };
    appsBaseline = packages.lists.appsBaseline;
    appsNonGUI = packages.lists.appsNonGUI;
    appsGUI = packages.lists.appsGUI;
    appsNvidia = appsNvidia;

  # Build list of packages to be installed on the host
  pkgsList =
    let
      pkgsList =
        if hosts.isRoleLaptop then
          appsBaseline ++
          appsNonGUI ++
          appsGUI

        else if hosts.isRoleServer then
          appsBaseline ++
          appsNonGUI ++
          [
            pkgs.pinentry-curses
          ]
        else [];
    in
      if hosts.isNvidiaGPUHost then pkgsList ++ appsNvidia
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
    # permittedInsecurePackages = [ "openssl-1.1.1w" ]; # Sublime 4
  };

  # =====  systemPackages  =====
  # Install packages system-wide based on the host
  environment.systemPackages = pkgsList;
}
