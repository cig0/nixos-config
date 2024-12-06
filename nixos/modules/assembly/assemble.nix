# assemble.nix
# This file assembles the lists of packages to be installed on a host.
#
# TODO: clean up this mess! The plan would be:
# [x] Create a new install.nix or assemble.nix file to assemble all the groups of packages depending on the role of the host(s)
# [ ] Move all the configurations for individual applications/tools to a separate file.

{ config, lib, pkgs, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };

  # Applications
    kasmwebConfig = import ../applications/kasmweb.nix { inherit config; };
    mtrConfig = import ../applications/mtr.nix { inherit config; };
    osqueryConfig = import ../applications/osquery.nix { inherit config; };
  # Observability
    grafanaAlloyConfig = import ../observability/grafana-alloy.nix { inherit config; };

  # Packages Lists
  packages = import ../applications/packages.nix { inherit pkgs; };
    nonGUIApps = packages.lists.nonGUIApps;
    graphicalUIApps = packages.lists.graphicalUIApps;

  pkgsList =
    let
      pkgsList = if hostnameLogic.isRoleUser then nonGUIApps ++ graphicalUIApps
        else if hostnameLogic.isRoleServer then nonGUIApps ++ [
          pkgs.cockpit
          pkgs.pinentry-curses
        ]
        else [ ];
    in
      if hostnameLogic.isNvidiaGPUHost then pkgsList ++ [ pkgs.nvtop ]
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
  security.chromiumSuidSandbox.enable = hostnameLogic.isRoleUser;

  # TODO: move to its own file
  programs = {
    firefox = { # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
      enable = true;
      preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };
    };
  };

  services = {
    kasmweb = kasmwebConfig.services.kasmweb // {
      enable = hostnameLogic.isRoleServer;
    };
    osquery = osqueryConfig.services.osquery;
  };

  # =====  systemPackages  =====
  # Install packages system-wide based on the host
  environment.systemPackages = pkgsList;
}
