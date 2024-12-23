# Hosts mapping.

{ config, lib, ... }:

let
  # TODO: I'm keeping this mkIf around for now as a reminder of how to implement this.
  inherit (lib) mkIf;
  myHostName = config.networking.hostName; # Extra fail-check.

in
  rec {
    # Export mkIf for reuse.
    mkIf = lib.mkIf;

    # ====  Define truthiness for the hosts and logical groupings
    # Individual hosts definition by name.
    isPerrrkele = myHostName == "perrrkele";
    isSatama = myHostName == "satama";
    isKoira = myHostName == "koira";

    # Logical groupings
      # By hardware
      isChuweiMiniPC = isSatama;
      isDesktop = isKoira;
      isTuxedoInfinityBook = isPerrrkele;

      # By GPU
      isIntelGPUHost = isChuweiMiniPC || isTuxedoInfinityBook;  # Combined condition for Intel iGPU hosts.
      isNvidiaGPUHost = isKoira;

      # By role
      isRoleLaptop = isTuxedoInfinityBook;
      isRoleServer = isChuweiMiniPC;
      isRoleUser = isDesktop || isTuxedoInfinityBook;  # Combined condition for user-side hosts.
}


# Notes & examples
# ----------------
#
# - Don't forget to add `config, lib,` to the module you will be importing this module from
# - MYHOST -> proper hostname


# let
#   hosts = import ../../lib/hosts.nix { inherit config lib; };
# in
#
# {
#   myFunction = hostnameLogic.mkIf hostnameLogic.isMYHOST {
#     ...
#   };
# }
# {
#  myFunction =
#    if hostnameLogic.isPerrrkele then
#      something
#    else if hostnameLogic.isSatama then
#      "something else"
#    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
# }
