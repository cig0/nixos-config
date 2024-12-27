# TODO
# Treat hosts as cattle, not as a pet. The only important thing is the flake. The flake rule us. We obey the flake. The flake is the only source of authotority. All praises to the flake!
# [ ] Drop hand-picked hostnames and use the Type of the host instead, e.g. laptop, desktop, homelab => isLaptop, isDesktop, isHomeLab, etc.
# [ ] Replace all references to "Server" for "HomeLab" as it's more accurate.

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
      isIntelGPUHost = isChuweiMiniPC || isTuxedoInfinityBook;  # Combined condition for Intel iGPU hostSelector
      isNvidiaGPUHost = isKoira;

      # By role
      isRoleLaptop = isTuxedoInfinityBook;
      isRoleServer = isChuweiMiniPC;
      isRoleUser = isDesktop || isTuxedoInfinityBook;  # Combined condition for user-side hostSelector
}


# Notes & examples
# ----------------
#
# - Don't forget to add `config, lib,` to the module you will be importing this module from
# - MYHOST -> proper hostname


# let
#   hostSelector = import ../../lib/host-selector.nix { inherit config lib; };
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
