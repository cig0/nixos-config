{
  ...
}:
{
  hardware.cpu.intel.updateMicrocode = true;

  services = {
    fwupd.enable = true;
    zram-generator.enable = true;
  };

  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 5;
  };

  mySystem = {
    hardware = {

      # Bluetooth
      bluetooth.enable = true;

      # Hardware Acceleration
      graphics.enable = true;
    };

    myOptions = {
      hardware = {
        cpu = "intel";
        gpu = "intel";
      };
    };
  };
}
