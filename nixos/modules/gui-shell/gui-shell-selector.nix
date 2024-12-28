{ lib, ... }:

{
  options.mySystem.guiShellEnv = lib.mkOption {
    type = lib.types.enum [ "none" "plasma6" "cosmic" ];
    default = "none";
    description = "Desktop environment or Window Manager to use";
  };

  imports = [
    # Import all GUI shell-specific modules - they'll activate themselves based on the configuration
    # KDE Plasma Desktop Environment
      ./kde-plasma.nix
      ../programs/kde/kde-pim.nix
      ../programs/kde/kdeconnect.nix

    # COSMIC Desktop Environment
      ./cosmic.nix

    # ... other GUI shells modules
  ];
}