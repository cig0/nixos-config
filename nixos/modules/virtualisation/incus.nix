{ config, lib, ... }:

let
  cfg = config.mySystem.virtualisation.incus.enable;

in {
  options.mySystem.virtualisation.incus.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable LXD fork (Linux containers)";
  };

  config = lib.mkIf (cfg == true) {
    virtualisation.incus = {
      enable = true;
      socketActivation = true;
      startTimeout = 120;
    };
  };
}