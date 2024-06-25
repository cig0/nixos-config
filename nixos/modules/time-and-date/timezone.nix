# TODO add logic to dynamically update the time zone at build time depending on
# what region of the planet I'm connecting to the intertubez from.


{ config, lib, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };
in
{
  time.timeZone =
    if hostnameLogic.isPerrrkele then
      "America/Argentina/Buenos_Aires"

    else if hostnameLogic.isSatama then
      "America/Argentina/Buenos_Aires"

    else if hostnameLogic.isVittusaatana then
      "America/Argentina/Buenos_Aires"

    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
}