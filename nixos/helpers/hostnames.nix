{ config, lib, ... }:

let
  inherit (lib) mkIf;
  isPerrrkele = config.networking.hostName == "perrrkele";
  isSatama = config.networking.hostName == "satama";
  isVittusaatana = config.networking.hostName == "vittusaatana";
  isIntelHost = isPerrrkele || isSatama;  # Combined condition for Intel iGPU hosts
in
{
  mkIf = mkIf;
  isPerrrkele = isPerrrkele;
  isSatama = isSatama;
  isVittusaatana = isVittusaatana;
  isIntelHost = isIntelHost;
}


# Copy & paste ready!
# let
#   hostnameLogic = import ../helpers/hostnames.nix { inherit config lib; };
# in