{ config, lib, ... }:

let
  hostSelector = import ../../lib/host-selector.nix { inherit config lib; };
in
{
  services.zram-generator.enable = true;
  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent =
      if hostSelector.isChuweiMiniPC then 5
      else if hostSelector.isDesktop then 25
      else if hostSelector.isTuxedoInfinityBook then 15
      else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
  };
}