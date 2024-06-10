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


# Ready for copy & paste
# -----------------------

# (Don't forget to add config, and lib, to the moduel you will be importing this module from!)

# let
#   hostnameLogic = import ../helpers/hostnames.nix { inherit config lib; };
# in
# {
    # myFunction =
    #   if hostnameLogic.isPerrrkele then
    #     something

    #   else if hostnameLogic.isSatama then
    #     "something else"

    #   else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
# }