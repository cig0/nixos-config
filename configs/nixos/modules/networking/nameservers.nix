/*
  DNS providers sorted alphabetically (pick your poison)
  ------------------------------------------------------
  94.140.14.14      AdGuard DNS default servers :: https://adguard-dns.io/en/public-dns.html
  94.140.15.15      AdGuard DNS default servers :: https://adguard-dns.io/en/public-dns.html
  208.67.222.123    Cisco OpenDNS
  1.1.1.1           Cloudflare
  95.85.95.85       GCore Free :: https://gcore.com/public-dns
  2.56.220.2        GCore Free :: https://gcore.com/public-dns
  8.8.8.8           GoogleDNS
  194.242.2.6       Mullvad Public DNS :: https://mullvad.net/en/help/dns-over-https-and-dns-over-tls
  64.6.64.6         Verisign DNS :: https://www.verisign.com/

  References:
  https://wikileaks.org/wiki/Alternative_DNS
  https://prism-break.org/en/all/#dns
  https://www.privacyguides.org/en/dns/
  https://www.privacytools.io/encrypted-dns
*/
{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "myNixos" "networking" "nameservers" ] config;
in
{
  options.myNixos.networking.nameservers = lib.mkEnableOption "The list of nameservers.It can be left empty if it is auto-detected through DHCP.";

  config = lib.mkIf cfg {
    networking = {
      nameservers = [
        "194.242.2.6"
        "1.1.1.1"
      ];
    };
  };
}
