{ ... }:

let
  nixosPool =  import ../../../modules/system/ntp.nix;

in {
  # Set NTP servers pool
  # networking.timeServers = argentinaNTPpool ++ nixosNTPpool;
  networking.timeServers = nixosPool;

  time.timeZone = "Europe/Warsaw";
}