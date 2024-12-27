# Assemble the lists and sets of packages to be installed on a host according to the host's role and the GUI shell in use.

{ config, lib, pkgs, unstablePkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hostSelector = import ../../../lib/host-selector.nix { inherit config lib; };

  # Import packages lists and sets.
  p = import ./packages.nix { inherit pkgs unstablePkgs; };

  # Function to create package lists based on host roles.
  rolePackages = role:
    let
      appsGUIshell =  # Dynamically add packages based on the enabled GUI shell.
        lib.optionals (config.services.desktopManager.cosmic.enable or false) p.sets.appsGUIshell.COSMIC ++
        lib.optionals (config.services.desktopManager.hyprland.enable or false) p.sets.appsGUIshell.Hyprland ++
        lib.optionals (config.services.desktopManager.plasma6.enable or false) p.sets.appsGUIshell.KDE ++
        lib.optionals (config.services.desktopManager.xfce.enable or false) p.sets.appsGUIshell.XFCE
      ;
    in
      (lib.optionals (role == "Laptop" || role == "Desktop") (
        p.lists.appsBaseline ++
        p.lists.appsGUI ++
        p.lists.appsNonGUI ++
        appsGUIshell
      )) ++
     (lib.optionals (role == "Server") (
        p.lists.appsBaseline ++
        p.sets.appsNonGUI.backup ++
        p.sets.appsNonGUI.cloudNativeTools ++
        p.sets.appsNonGUI.security ++
        p.sets.appsNonGUI.vcs
        [
          pkgs.pinentry-curses
        ]
     ));

  assembledList =
    let
      assembly = if hostSelector.isRoleLaptop then rolePackages "Laptop"
                 else if hostSelector.isRoleServer then rolePackages "Server"
                 else [];
    in
      assembly ++ lib.optionals hostSelector.isNvidiaGPUHost p.lists.appsNvidia;  # Add Nvidia packages as needed.

in
{
  imports = builtins.filter (x: x != null) [
    # ./systemPackages-overrides.nix
  ];

  # Allow lincense-burdened packages.
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Install packages system-wide based on the host role.
  environment.systemPackages = assembledList;
}