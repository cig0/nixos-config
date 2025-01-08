# TODO
# Treat hosts as cattle, not as a pet. The only important thing is the flake. The flake rule us. We obey the flake. The flake is the only source of authotority. All praises to the flake!
# [ ] Drop hand-picked hostnames and use the Type of the host instead, e.g. laptop, desktop, homelab => isLaptop, isDesktop, isHomeLab, etc.
# [ ] Replace all references to "Server" for "HomeLab" as it's more accurate.

# Hosts mapping.

{ config, ... }:

let
  # TODO: I'm keeping this mkIf around for now as a reminder of how to implement this.
  myHostName = config.networking.hostName;

  # Hosts definition by kind.
  # I'm moving away from giving proper names to hosts, and instead using the hostname as a reference.
  # With NixOS I can finally treat hosts as cattle, not as a pet.
  isTuxedoInfinityBook = myHostName == "TuxedoInfinityBook";
  isChuweiMiniPC = myHostName == "ChuweiMiniPC";
  isDesktop = myHostName == "desktop";
  # Aliases
    isLaptop = isTuxedoInfinityBook;

  # Role groupings
  isRoleGraphical = isDesktop || isLaptop;  # Combined condition for user-side hostSelector

  # GPU grpupings
  isIntelGPUHost = isChuweiMiniPC || isTuxedoInfinityBook;  # Combined condition for Intel iGPU hostSelector
  isNvidiaGPUHost = isDesktop;

in {
    inherit isChuweiMiniPC isDesktop isLaptop isTuxedoInfinityBook;
    inherit isRoleGraphical;
    inherit isIntelGPUHost isNvidiaGPUHost;
}