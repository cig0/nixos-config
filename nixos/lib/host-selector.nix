{ config, ... }:

let
  myHostName = config.networking.hostName;

  # I'm moving away from giving proper names to hosts, and instead using the hostname as a reference.
  # With NixOS I can finally treat hosts as cattle, not as a pet.

  # Hosts definitions.
  isTuxedoInfinityBook = myHostName == "TuxedoInfinityBook";
  isChuweiMiniPC = myHostName == "ChuweiMiniPC";
  isWorkstation = myHostName == "workstation";

    # Aliases.
    isDesktop = isWorkstation;
    isHomeLab = isChuweiMiniPC;
    # isHomeNAS =  # TBD
    isLaptop = isTuxedoInfinityBook;
    isRoleGraphical = isDesktop || isLaptop;  # Combined condition for user-side hostSelector

  # GPU grpupings.
  isIntelGPUHost = isChuweiMiniPC || isTuxedoInfinityBook;  # Combined condition for Intel iGPU hostSelector
  isNvidiaGPUHost = isWorkstation;

in {
    inherit isChuweiMiniPC isTuxedoInfinityBook isWorkstation;
    inherit isDesktop isHomeLab isLaptop isRoleGraphical;
    inherit isIntelGPUHost isNvidiaGPUHost;
}