{
  config,
  ...
}:
{
  mySystem = {
    hardware = {
      # bluetooth.nix
      bluetooth.enable = true;

      # graphics-acceleration.nix :: Hardware Acceleration
      graphics.enable = true;

      # NVIDIA CNDF containers passthrough
      nvidia-container-toolkit.enable = true;
    };

    # cpu-gpu.nix
    myOptions.hardware.cpu = "intel";
    myOptions.hardware.gpu = "nvidia";
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
    memoryPercent = 15;
  };
}
