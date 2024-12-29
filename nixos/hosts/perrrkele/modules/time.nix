{ ... }:

let
  ntpPools =  import ../../../modules/system/ntp.nix;

in {
  networking.timeServers = ntpPools.nixosPool;
  time.timeZone = "Europe/Warsaw";
}