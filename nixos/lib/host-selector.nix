{config, ...}: let
  myHostName = config.networking.hostName;

  # I'm moving away from giving proper names to hosts, and instead using the hostname as a reference.
  # With NixOS I can finally treat hosts as cattle, not as pets anymore.

  # Hosts definitions.
  isTUXEDOInfinityBookPro = myHostName == "TUXEDOInfinityBookPro";
  isChuweiMiniPC = myHostName == "ChuweiMiniPC";
  isWorkstation = myHostName == "workstation";

  # Aliases.
  isDesktop = isWorkstation;
  isHomeLab = isChuweiMiniPC;
  # isHomeNAS =  # TBD
  isLaptop = isTUXEDOInfinityBookPro;
  isRoleGraphical = isDesktop || isLaptop; # Combined condition for user-side hostSelector

  # GPU grpupings.
  isIntelGPUHost = isChuweiMiniPC || isTUXEDOInfinityBookPro; # Combined condition for Intel iGPU hostSelector
  isNvidiaGPUHost = isWorkstation;
in {
  inherit
    isChuweiMiniPC
    isTUXEDOInfinityBookPro
    isWorkstation
    isDesktop
    isHomeLab
    isLaptop
    isRoleGraphical
    isIntelGPUHost
    isNvidiaGPUHost
    ;
}
