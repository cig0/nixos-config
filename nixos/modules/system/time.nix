{ ... }:

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
      fetchurl {
        url = "https://ipapi.co/json/";
        sha256 = "0h1k9blcb4yjb32xh3in3h8lm8y5h6zqv1zlm7ln7vb1ij1aln65";
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
    else if region == "NA" then [
      "0.north-america.pool.ntp.org"
    ] ++ commonNTPPool
    else if region == "EU" then [
      "0.europe.pool.ntp.org"
    ] ++ commonNTPPool
    else commonNTPPool;
in
{
  # Set NTP servers pool
  networking.timeServers = ntpPool;

  # Dynamically set the timezone
  services = {
    automatic-timezoned.enable = true;
    localtimed.enable = true;
    tzupdate.enable = true;
  };
}