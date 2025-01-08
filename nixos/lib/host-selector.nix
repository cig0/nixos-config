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
    inherit isChuweiMiniPC isTuxedoInfinityBook;
    inherit isDesktop isHomeLab isLaptop isRoleGraphical;
    inherit isIntelGPUHost isNvidiaGPUHost;
}


# TODO:
# [x] Drop hand-picked hostnames; treat hosts as cattle, not as a pet. The only important thing is the flake. The flake rule us. We obey the flake. The flake is the only source of authotority. All praises to the flake!
# [x] Replace all references to "Server" for "HomeLab" as it's more accurate.