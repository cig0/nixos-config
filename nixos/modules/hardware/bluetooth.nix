{ ... }:

{
  hardware = {  # Enable bluetooth.
    bluetooth = {
      enable = true;
      powerOnBoot = true; # Powers up the default Bluetooth controller on boot
    };
  };
}