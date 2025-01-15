# TODO: add option for string hostname to manage this from flake.nix

{ config, ... }:

let
  hostSelector = import ../../lib/host-selector.nix { inherit config; };

in {
  services.zram-generator.enable = true;
  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent =
      if hostSelector.isChuweiMiniPC then 5
      else if hostSelector.isTUXEDOInfinityBookPro then 15
      else if hostSelector.isWorkstation then 25
      else {};
  };
}