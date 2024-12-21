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

    # Import all DE-specific modules - they'll activate themselves based on the configuration
    ../applications/kde/kde-pim.nix
    ./kde.nix
    # ... other DE modules
  ];
}