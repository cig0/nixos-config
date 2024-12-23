# restic.nix
# Hosts backup strategies using restic.

{ config, lib, ... }:

let
  hostSelector = import ../../../lib/host-selector.nix { inherit config lib; };

  # Build list of packages to be installed on the host
  backupJob =
    let
      backupJob =
        if hostSelector.isRoleLaptop then


        else if hostSelector.isRoleServer then


        else if hostSelector.isDesktop then


        else [];
    in
      if hostSelector.isNvidiaGPUHost then pkgsList ++ appsNvidia
      else
        pkgsList;

in
{


}