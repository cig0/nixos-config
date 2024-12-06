# assemble.nix
# This file assembles the lists of packages to be installed on a host.
#
# TODO: clean up this mess! The plan would be:
# [x] Create a new install.nix or assemble.nix file to assemble all the groups of packages depending on the role of the host(s)
# [ ] Move all the configurations for individual applications/tools to a separate file.

{ config, lib, pkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  host = import ../../helpers/hostnames.nix { inherit config lib; };

  # Applications
    kasmwebConfig = import ../applications/kasmweb.nix { inherit config; };
    mtrConfig = import ../applications/mtr.nix { inherit config; };
    osqueryConfig = import ../applications/osquery.nix { inherit config; };
  # Observability
    grafanaAlloyConfig = import ../observability/grafana-alloy.nix { inherit config; };

  # Packages Lists
  packages = import ../applications/packages.nix { inherit pkgs; };
    # appsBaseline = packages.lists.appsBaseline;
    # appsNonGUI = packages.lists.appsNonGUI;
    # appsGUI = packages.lists.appsGUI;
    roleLaptop = packages.lists.roleLaptop;
    roleServer = packages.lists.roleServer;

  pkgsList =
    let
      pkgsList = if host.isRoleLaptop then roleLaptop
        else if host.isRoleServer then roleServer ++ [
          pkgs.pinentry-curses
        ]
        else [ ];
    in
      if host.isNvidiaGPUHost then pkgsList ++ [ pkgs.nvtop ]
      else
        pkgsList;
in
{
  imports = builtins.filter (x: x != null) [
    # ./systemPackages-overrides.nix
    #TODO: implement appropriate logic to correctly assemble the host's derivation
    # Applications
      mtrConfig
    # Observability
      grafanaAlloyConfig
  ];

  # Allow lincense-burdened packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "openssl-1.1.1w" ]; # Sublime 4
  };

  ## GNOME Desktop
  environment.gnome.excludePackages = (with pkgs; [ # for packages that are pkgs.***
    gnome-tour
    gnome-connections
      ]) ++ (with pkgs.gnome; [ # for packages that are pkgs.gnome.***
      epiphany # web browser
      geary # email reader
      evince # document viewer
  ]);

  # TODO: move to its own file
  #===  Chromium options
  security.chromiumSuidSandbox.enable = host.isRoleUser;

  # TODO: move to its own file
  programs = {
    firefox = { # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
      enable = true;
      preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };
    };
  };

  services = {
    kasmweb = kasmwebConfig.services.kasmweb // {
      enable = host.isRoleServer;
    };
    osquery = osqueryConfig.services.osquery;
  };

  # =====  systemPackages  =====
  # Install packages system-wide based on the host
  environment.systemPackages = pkgsList;
}
