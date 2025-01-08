# Assemble the lists and sets of packages to be installed on a host according to the host's role and the GUI shell in use.

{ config, lib, pkgs, unstablePkgs, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hostSelector = import ../../lib/host-selector.nix { inherit config lib; };

  # Import packages lists and sets.
  p = import ./packages.nix { inherit pkgs unstablePkgs; };

  # Function to create package lists based on host roles.
  hostPackages = hP:
    let appsGuiShell =  # Dynamically add packages based on the enabled GUI shell.
        lib.optionals (config.services.desktopManager.cosmic.enable or false) p.sets.appsGuiShell.cosmic ++
        lib.optionals (config.programs.hyprland.enable or false) p.sets.appsGuiShell.hyprland ++
        lib.optionals (config.services.desktopManager.plasma6.enable or false) p.sets.appsGuiShell.kde ++
        lib.optionals (config.programs.wayfire.enable or false) p.sets.appsGuiShell.wayfire ++
        lib.optionals (config.services.desktopManager.xfce.enable or false) p.sets.appsGuiShell.xfce
      ;
    in
      (lib.optionals (hP == "Graphical") (
        p.lists.appsBaseline ++
        p.lists.appsGui ++
        p.lists.appsCli ++
        appsGuiShell
      )) ++
     (lib.optionals (hP == "HomeLab") (
        p.lists.appsBaseline ++
        p.sets.appsCli.backup ++
        p.sets.appsCli.cloudNativeTools ++
        p.sets.appsCli.security ++
        p.sets.appsCli.vcs
        [
          pkgs.pinentry-curses
        ]
     ));

  systemPackages =  let sP = if hostSelector.isRoleGraphical then hostPackages "Graphical"
                      else if hostSelector.isHomeLab then hostPackages "HomeLab"
                      else [];
                    in
                      sP ++ lib.optionals hostSelector.isNvidiaGPUHost p.lists.appsNvidia;  # Add Nvidia packages as needed.

in {
  # The NixOS community generally recommends keeping the enabling/disabling logic in the individual module files rather than in the importing module.
  # This follows the principle of separation of concerns and makes modules more self-contained.
  # Benefits of this approach:
  #   - Each module controls its own destiny
  #   - Modules are self-contained
  #   - Easier to maintain and understand
  #   - Follows the NixOS convention of modules managing their own conditional activation
  #   - Makes it easier to override in specific cases if needed
  #   - This is the more idiomatic NixOS way of handling conditional module activation.
  imports = builtins.filter (x: x != null) [
    # ../systemPackages-overrides.nix
    ./atop.nix  # System usage monitoring
    ./chromium.nix  # Hardening
    # ./emacs.nix
    ./firefox.nix
  ];

  # Allow lincense-burdened packages.
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Install packages system-wide based on the host role.
  environment.systemPackages = systemPackages;
}