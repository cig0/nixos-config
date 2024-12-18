# Assemble the lists and sets of packages to be installed on a host according to the host's role and the GUI shell in use when applicable.

{ config, lib, pkgs, unstablePkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hosts = import ../../../helpers/hostnames.nix { inherit config lib; };

  # Import packages lists and sets.
  packages = import ./packages.nix { inherit pkgs unstablePkgs; };

  # Function to create package lists based on host roles.
  rolePackages = role:
    let
      appsGUIshell =  # Dynamically add packages based on the enabled GUI shell.
        lib.optionals (config.services.desktopManager.cosmic.enable or false) packages.sets.appsGUIshell.COSMIC ++
        lib.optionals (config.services.desktopManager.hyprland.enable or false) packages.sets.appsGUIshell.Hyprland ++
        lib.optionals (config.services.desktopManager.plasma6.enable or false) packages.sets.appsGUIshell.KDE ++
        lib.optionals (config.services.desktopManager.xfce.enable or false) packages.sets.appsGUIshell.XFCE
      ;
    in
      (lib.optionals (role == "Laptop") (
        packages.lists.appsBaseline ++
        packages.lists.appsGUI ++
        packages.lists.appsNonGUI ++
        appsGUIshell
      )) ++
     (lib.optionals (role == "Server") (
        packages.lists.appsBaseline ++
        packages.sets.appsNonGUI.infrastructure ++
        packages.sets.appsNonGUI.vcs ++
        [
          pkgs.pinentry-curses
        ]
     ));

  # 👨‍🏭🤖🔩🔧 Assembly line.
  assembledList =
    let
      assembly = if hosts.isRoleLaptop then rolePackages "Laptop"
                 else if hosts.isRoleServer then rolePackages "Server"
                 else [];
    in
      assembly ++ lib.optionals hosts.isNvidiaGPUHost packages.lists.appsNvidia;  # Add Nvidia packages as needed.

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
