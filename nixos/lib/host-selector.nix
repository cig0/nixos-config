# TODO
# Treat hosts as cattle, not as a pet. The only important thing is the flake. The flake rule us. We obey the flake. The flake is the only source of authotority. All praises to the flake!
# [ ] Drop hand-picked hostnames and use the Type of the host instead, e.g. laptop, desktop, homelab => isLaptop, isDesktop, isHomeLab, etc.
# [ ] Replace all references to "Server" for "HomeLab" as it's more accurate.

# Hosts mapping.

{ config, ... }:

let
  # TODO: I'm keeping this mkIf around for now as a reminder of how to implement this.
  myHostName = config.networking.hostName;

  # Hosts definition by name.
  isPerrrkele = myHostName == "perrrkele";
  isSatama = myHostName == "satama";
  isKoira = myHostName == "koira";

  # Hardware mappings.
  isChuweiMiniPC = isSatama;
  isDesktop = isKoira;
  isLaptop = isTuxedoInfinityBook;
  isTuxedoInfinityBook = isPerrrkele;

  # Role groupings
  isRoleGraphical = isDesktop || isLaptop;  # Combined condition for user-side hostSelector

  # GPU grpupings
  isIntelGPUHost = isChuweiMiniPC || isTuxedoInfinityBook;  # Combined condition for Intel iGPU hostSelector
  isNvidiaGPUHost = isKoira;

in {
    inherit isPerrrkele isSatama isKoira;
    inherit isChuweiMiniPC isDesktop isLaptop isTuxedoInfinityBook;
    inherit isRoleGraphical;
    inherit isIntelGPUHost isNvidiaGPUHost;
}