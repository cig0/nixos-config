{
  ...
}:
{
  # NixOS host-specific options
  hardware.cpu.intel.updateMicrocode = true;

  services = {
    fwupd.enable = true;
    snap.enable = true; # nix-snapd
    zram-generator.enable = true;
  };

  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 5;
  };
}
