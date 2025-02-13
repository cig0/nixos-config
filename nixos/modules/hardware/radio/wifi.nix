# Don't remove this line! This is a NixOS hardware module.

{
  config,
  lib,
  ...
}: let
  cfg = {
    powerSave = config.mySystem.networking.networkmanager.wifi.powersave;
    enable = config.mySystem.networking.wireless.enable;
  };
in {
  options.mySystem = {
    networking.networkmanager.wifi.powersave = lib.mkEnableOption "Whether to enable Wi-Fi power saving (can cause kernel panics).";

    networking.wireless.enable = lib.mkEnableOption "Whether to enable wpa_supplicant.";
  };

  config = {
    networking.networkmanager.wifi.powersave = cfg.powerSave; # Disabled, as it makes buggy drivers crash under heavy CPU load or when waking up back from suspend. Can be re-enabled on a per-host basis depending on the chipset/driver.
    networking.wireless.enable = cfg.enable;
  };
}
