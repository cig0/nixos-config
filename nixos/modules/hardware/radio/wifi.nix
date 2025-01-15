{ config, lib, ... }:

let
  cfg = config.mySystem.wifi-powersave;

in {
  options.mySystem.wifi-powersave = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable WiFi radio power saving (can cause kernel panics)";
  };

  config = lib.mkIf (cfg == true) {
    networking.networkmanager.wifi.powersave = true;  # Disabled, as it makes buggy drivers crash under heavy CPU load or when waking up back from suspend. Can be re-enabled on a per-host basis depending on the chipset/driver.
  };
}