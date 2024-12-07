# assemble.nix
# This file assembles the lists of packages to be installed on a host.
#
# TODO: clean up this mess! The plan would be:
# [x] Create a new install.nix or assemble.nix file to assemble all the groups of packages depending on the role of the host(s)
# [ ] Move all the configurations for individual applications/tools to a separate file.

{ config, lib, pkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hosts = import ../../helpers/hostnames.nix { inherit config lib; };

  # Applications
    # kasmwebConfig = import ../applications/kasmweb.nix { inherit config; };
    # mtrConfig = import ../applications/mtr.nix { inherit config; };
    # osqueryConfig = import ../system/osquery.nix { inherit config; };
  # Observability
    # grafanaAlloyConfig = import ../observability/grafana-alloy.nix { inherit config; };

  # Packages Lists
  packages = import ../applications/packages.nix { inherit pkgs; };
    # appsBaseline = packages.lists.appsBaseline;
    # appsNonGUI = packages.lists.appsNonGUI;
    # appsGUI = packages.lists.appsGUI;
    roleLaptop = packages.lists.roleLaptop;
    roleServer = packages.lists.roleServer;

  pkgsList =
    let
      pkgsList = if hosts.isRoleLaptop then roleLaptop
        else if hosts.isRoleServer then roleServer ++ [
          pkgs.pinentry-curses
        ]
        else [ ];
    in
      if hosts.isNvidiaGPUHost then pkgsList ++ [ pkgs.nvtop ]
      else
        pkgsList;
in
{
  imports = builtins.filter (x: x != null) [
    # ./systemPackages-overrides.nix
    #TODO: implement appropriate logic to correctly assemble the host's derivation
    # Applications
      ../applications/kde/kde-pim.nix
      ../applications/kde/kdeconnect.nix
      ../networking/mtr.nix
    # Observability
      # ../observability/grafana-alloy.nix
    # System
      # ../system/osquery.nix
  ];

  # Allow lincense-burdened packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "openssl-1.1.1w" ]; # Sublime 4
  };

  # TODO: move to its own file
  #===  Chromium options
  security.chromiumSuidSandbox.enable = hosts.isRoleUser;

  # TODO: move to its own file
  programs = {
    firefox = { # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
      enable = true;
      preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };
    };
  };

  # =====  systemPackages  =====
  # Install packages system-wide based on the host
  environment.systemPackages = pkgsList;
}
