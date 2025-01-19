let
  laptopSettings =
    (import ./user-settings.nix)
    // {
      # Power Management
      mySystem.programs.auto-cpufreq.enable = true;
      mySystem.powerManagement.enable = true;

      # Radio
      mySystem.hardware.bluetooth.enable = true;

      # System - Kernel
      mySystem.boot.kernelPackages = "latest";
    };
in
  laptopSettings
