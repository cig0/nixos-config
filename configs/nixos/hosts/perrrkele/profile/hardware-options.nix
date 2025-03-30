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
      graphics.enable = true;

      # Radio
      bluetooth.enable = true;
    };

    myOptions = {
      hardware = {
        cpu = "intel";
        gpu = "intel";
      };
    };
  };
}
