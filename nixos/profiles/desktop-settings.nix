let
  desktopSettings =
    (import ./user-settings.nix)
    // {
      # Desktop-specific settings
      mySystem.powerManagement.enable = false;
      mySystem.hardware.bluetooth.enable = false;
      mySystem.hardware.gpu.enable = true;
      mySystem.boot.kernelPackages = "latest";
    };
in
  desktopSettings
