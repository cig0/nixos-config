{ pkgs, ... }:

let
  commonNTPPool = [
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
  ];

  # Geolocation data fetching
  regionData = builtins.fromJSON (
    builtins.readFile (
      pkgs.fetchurl {
        url = "https://ipapi.co/json/";
        sha256 = "9CSp6Tc7dmQcj3UewQb8ZxUpz/bngzuHGTr/osCVCcw=";
      }
    )
  );

  # Set NTP pool according to region
  region = regionData.continent_code;
  ntpPool =
    if region == "SA" then [
      "1.ar.pool.ntp.org"
      "0.south-america.pool.ntp.org"
    ] ++ commonNTPPool
    else if region == "NA" then [ "0.north-america.pool.ntp.org" ] ++ commonNTPPool
    else if region == "EU" then [ "0.europe.pool.ntp.org" ] ++ commonNTPPool
    else commonNTPPool;
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