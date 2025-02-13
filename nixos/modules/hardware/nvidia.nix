# Don't remove this line! This is a NixOS hardware module.

{ config, lib, ... }:

let
  cfg = config.mySystem.hardware.nvidia-container-toolkit.enable;

in {
  options.mySystem.hardware.nvidia-container-toolkit.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable dynamic CDI configuration for Nvidia devices by running
nvidia-container-toolkit on boot.";
  };

  config = {
    hardware.nvidia-container-toolkit.enable = cfg;
  };
}