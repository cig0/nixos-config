# TODO:
# - Dynamically configure NTP pool depending on timezonne/region
# - Move the 'let' block to a separate file (💡: rename this file to ntp.nix or ntp-pools.nix), and the in block to a separate file in the corrsponding ./nixos/hosts/$YOUR_HOST/modules directory.

{ config, lib, ... }:

let
  hostSelector = import ../../../lib/host-selector.nix { inherit config lib; };

  nixosNTPpool = [
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
  ];

  argentinaNTPpool = [
    "1.ar.pool.ntp.org"
    "0.south-america.pool.ntp.org"
  ];

  naNTPpool = [
    "0.north-america.pool.ntp.org"
  ];

  euNTPpool = [
    "0.europe.pool.ntp.org"
  ];
in
{
  # Set NTP servers pool
  # networking.timeServers = argentinaNTPpool ++ nixosNTPpool;
  networking.timeServers = nixosNTPpool;

  time.timeZone =
    if hostSelector.isPerrrkele then
      "Europe/Warsaw"

    else if hostSelector.isSatama then
      "America/Argentina/Buenos_Aires"

    else if hostSelector.isKoira then
      "America/Argentina/Buenos_Aires"

    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";

  # Dynamically set the timezone
  # services = {
  #   automatic-timezoned.enable = true;
  #   localtimed.enable = true;
  #   tzupdate.enable = true;
  # };
}
