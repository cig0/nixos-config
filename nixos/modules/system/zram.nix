# TODO: add option to manage memoryPercent
{config, ...}: let
  hostSelector = import ../../lib/host-selector.nix {inherit config;};
in {
  services.zram-generator.enable = true;
  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent =
      if hostSelector.isChuweiMiniPC
      then 5
      else if hostSelector.isTUXEDOInfinityBookPro
      then 15
      else if hostSelector.isWorkstation
      then 25
      else {};
  };
}
