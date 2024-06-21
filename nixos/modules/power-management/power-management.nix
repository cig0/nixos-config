# Energy saver

{ ... }:

{
  powerManagement = {
    enable = true;
    powertop.enable = false; # Need to troubleshoot the configured settings, as my wired external keyboard behaves erratically.
  };

  services.thermald.enable = true;
}