# https://wiki.nixos.org/wiki/NTP
# TODO evaluate adding capability to switch the NTP servers dynamically at build time
# depending on what region of the planet I'm connecting to the intertubez from.


{ ... }:

{
  networking.timeServers = [
    "1.ar.pool.ntp.org"
    "1.south-america.pool.ntp.org"
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
  ];
}