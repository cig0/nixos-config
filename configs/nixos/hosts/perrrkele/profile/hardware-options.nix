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

    networking = {
      /*
        networkmanager.wifi.powersave = false;

        Disabled, as it makes buggy drivers crash under heavy CPU load or when waking up back from
        suspend.
      */
      networkmanager.wifi.powersave = false;
    };

    myOptions = {
      hardware = {
        cpu = "intel";
        gpu = "intel";
      };
    };
  };
}
