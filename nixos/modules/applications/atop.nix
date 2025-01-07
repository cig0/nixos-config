{ config, lib, ... }:

let
  hostSelector = import ../../lib/host-selector.nix { inherit config lib; };

in {
  config = lib.mkIf (hostSelector.isChuweiMiniPC) {
    programs.atop = {
      enable = true;
      interval = 60;
      logFile = "/var/log/atop.log";
    };
  };
}