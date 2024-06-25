# TODO configure NTP pool depending on timezonne/region

{ pkgs, ... }:

let
  commonNTPPool = [
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
  ];

  argentinaNTPPool = [
    "1.ar.pool.ntp.org"
    "0.south-america.pool.ntp.org"
  ];

  naNTPPool = [
    "0.north-america.pool.ntp.org"
  ];

  euNTPPool = [
    "0.europe.pool.ntp.org"
  ];

  ntpPool = argentinaNTPPool ++ commonNTPPool;
in
{
  # Set NTP servers pool
  networking.timeServers = ntpPool;

  # Dynamically set the timezone
  services = {
    automatic-timezoned.enable = true;
    automatic-timezoned.package = pkgs.automatic-timezoned;
    localtimed.enable = true;
    tzupdate.enable = true;
  };
}