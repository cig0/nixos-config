# TODO: remove this module and remaining hardcoded logic tied to this module
{ config, ... }:
let
  myHostName = config.networking.hostName;

  # Hosts definitions.
  isPerrrkele = myHostName == "perrrkele";
  isChuweiMiniPC = myHostName == "ChuweiMiniPC";
  isWorkstation = myHostName == "workstation";

  # Aliases.
  isDesktop = isWorkstation;
  isHomeLab = isChuweiMiniPC;
  # isHomeNAS =  # TBD
  isLaptop = isPerrrkele;
  isRoleGraphical = isDesktop || isLaptop; # Combined condition for user-side hostSelector

  # GPU grpupings.
  isIntelGPUHost = isChuweiMiniPC || isPerrrkele; # Combined condition for Intel iGPU hostSelector
  isNvidiaGPUHost = isWorkstation;
in
{
  inherit
    isChuweiMiniPC
    isPerrrkele
    isWorkstation
    isDesktop
    isHomeLab
    isLaptop
    isRoleGraphical
    isIntelGPUHost
    isNvidiaGPUHost
    ;
}
