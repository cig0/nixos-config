{
  config,
  ...
}:
{
  mySystem = {
    hardware = {
      # bluetooth.nix
      bluetooth.enable = true;

      # graphics.nix :: Hardware Acceleration
      graphics.enable = true;
    };

    # cpu-gpu.nix
    myOptions.hardware.gpu = "intel";
    myOptions.hardware.cpu = "intel";
  };

  # NixOS built-in options
  hardware.cpu.${config.mySystem.myOptions.hardware.cpu}.updateMicrocode = true;

  services = {
    fwupd.enable = true;
    zram-generator.enable = true;
  };

  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 5;
  };
}
