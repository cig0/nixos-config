# chromium.nix - Chromium Web Browser

{ config, lib, ... }:

let
  # Host name logic. Loads a map of possible hostnames and their associated roles.
  hosts = import ../../helpers/hostnames.nix { inherit config lib; };
in
{
  security.chromiumSuidSandbox.enable = hosts.isRoleUser;
}