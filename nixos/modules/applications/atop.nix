{ config, lib, ... }:

let
  hostSelector = import ../../lib/host-selector.nix { inherit config lib; };

in {
  config = lib.mkIf (hostSelector.isHomeLab) {
    programs.atop = {
      enable = true;
    };
  };
}