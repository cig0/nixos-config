{ lib, ... }:

{
  options.mySystem.guiShellEnv = lib.mkOption {
    type = lib.types.enum [ "none" "plasma6" "cosmic" ];
    default = "none";
    description = "Desktop environment or Window Manager to use";
  };

  imports = [
    # Always import base modules
    ./xdg-desktop-portal.nix

    # Import all GUI shell-specific modules - they'll activate themselves based on the configuration
    # KDE Plasma Desktop Environment
      ./kde-plasma.nix
      ../applications/kde/kde-pim.nix
      ../applications/kde/kdeconnect.nix

    # ... other GUI shells modules
  ];
}