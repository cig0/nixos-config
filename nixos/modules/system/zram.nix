{ config, lib, ... }:

let
  hosts = import ../../lib/hosts.nix { inherit config lib; };
in
{
  services.zram-generator.enable = true;
  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent =
      if hosts.isChuweiMiniPC then 5
      else if hosts.isDesktop then 25
      else if hosts.isTuxedoInfinityBook then 15
      else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
  };
}