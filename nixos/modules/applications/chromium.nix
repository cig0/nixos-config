# chromium.nix - Chromium Web Browser

{ config, lib, ... }:

let
  hostSelector = import ../../lib/host-selector.nix { inherit config lib; };

in {
  config = lib.mkIf (hostSelector.isRoleGraphical) {
    security.chromiumSuidSandbox.enable = true;
  };
}