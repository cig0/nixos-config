# Assemble the lists and sets of packages to be installed on a host according to the host's role and the GUI shell in use.

{ config, lib, pkgs, unstablePkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hostSelector = import ../../lib/host-selector.nix { inherit config lib; };

  # Import packages lists and sets.
  p = import ./packages.nix { inherit pkgs unstablePkgs; };

  # Function to create package lists based on host roles.
  rolePackages = role:
    let
      appsGuiShell =  # Dynamically add packages based on the enabled GUI shell.
        lib.optionals (config.services.desktopManager.cosmic.enable or false) p.sets.appsGuiShell.cosmic ++
        lib.optionals (config.programs.hyprland.enable or false) p.sets.appsGuiShell.hyprland ++
        lib.optionals (config.services.desktopManager.plasma6.enable or false) p.sets.appsGuiShell.kde ++
        lib.optionals (config.programs.wayfire.enable or false) p.sets.appsGuiShell.wayfire ++
        lib.optionals (config.services.desktopManager.xfce.enable or false) p.sets.appsGuiShell.xfce
      ;
    in
      (lib.optionals (role == "Laptop" || role == "Desktop") (
        p.lists.appsBaseline ++
        p.lists.appsGui ++
        p.lists.appsNonGui ++
        appsGuiShell
      )) ++
     (lib.optionals (role == "HomeLab") (
        p.lists.appsBaseline ++
        p.sets.appsNonGui.backup ++
        p.sets.appsNonGui.cloudNativeTools ++
        p.sets.appsNonGui.security ++
        p.sets.appsNonGui.vcs
        [
          pkgs.pinentry-curses
        ]
     ));

  assembledList =
    let
      assembly = if hostSelector.isRoleLaptop then rolePackages "Laptop"
                 else if hostSelector.isRoleDesktop then rolePackages "Desktop"
                 else if hostSelector.isRoleServer then rolePackages "HomeLab"
                 else [];
    in
      assembly ++ lib.optionals hostSelector.isNvidiaGPUHost p.lists.appsNvidia;  # Add Nvidia packages as needed.

in {
  # The application modules installed with NixOS options are imported here.
  imports = builtins.filter (x: x != null) [
    # ../systemPackages-overrides.nix
    ./chromium.nix  # TODO: add option to enable/disable.
    ./firefox.nix  # TODO: add option to enable/disable.
  ];

  # Allow lincense-burdened packages.
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Install packages system-wide based on the host role.
  environment.systemPackages = assembledList;
}