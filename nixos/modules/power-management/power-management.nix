# Energy saver

{ ... }:

{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.thermald.enable = true;
}