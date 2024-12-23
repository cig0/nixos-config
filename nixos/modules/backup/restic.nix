# restic.nix
# Hosts backup strategies using restic.

{ config, lib, ... }:

let
  hosts = import ../../../lib/hosts.nix { inherit config lib; };

  # Build list of packages to be installed on the host
  backupJob =
    let
      backupJob =
        if hosts.isRoleLaptop then


        else if hosts.isRoleServer then


        else if hosts.isDesktop then


        else [];
    in
      if hosts.isNvidiaGPUHost then pkgsList ++ appsNvidia
      else
        pkgsList;

in
{


}