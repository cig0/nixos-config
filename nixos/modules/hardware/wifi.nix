{ ... }:

{
  networking.networkmanager.wifi.powersave = false;  # Disable, as it makes buggy drivers crash under heavy CPU load or when waking up back from suspend. Can be re-enabled on a per-host basis depending on the chipset/driver.
}