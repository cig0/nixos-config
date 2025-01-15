{ config, lib, ... }:

let
  cfg = config.mySystem.virtualisation.incus;

in {
  options.mySystem.virtualisation.incus = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable LXD fork (Linux containers)";
  };

  config = lib.mkIf (cfg == "true") {
    virtualisation.incus = {
      enable = true;
      socketActivation = true;
      startTimeout = 120;
    };
  };
}