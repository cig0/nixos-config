# Printing services.

{ config, lib, ... }:

let
  cfg = config.mySystem.services.printing;

in {
  options.mySystem.services.printing = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable CUPS printing service";
  };

  config = lib.mkIf (cfg == "true") {
    services.printing  = {
      enable = true;
      # drivers = [ "brlaser" "foomatic-db" "gutenprint" "hpcups" "hplip" "ipp" "papi3" "pnm2ppa" "pstotext" "rawtoaces" "splix" "ufraw" ];
    };
  };
}