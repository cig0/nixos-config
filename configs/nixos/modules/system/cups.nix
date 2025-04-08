# TODO: This is an old module, bring it up to date
{ config, lib, ... }:

let
  cfg = {
    printingEnable = config.mySystem.services.printing.enable;
    cupsPdfEnable = config.mySystem.services.printing.cups-pdf;
  };

in
{
  options.mySystem.services.printing = {
    enable = lib.mkOption {
      type = lib.types.bool; # lib.types.bool doesn't take arguments
      default = false;
      description = "Whether to enable printing support through the CUPS daemon.";
    };
    cups-pdf = lib.mkOption {
      type = lib.types.bool; # lib.types.bool doesn't take arguments
      default = false;
      description = "Whether to enable the cups-pdf virtual PDF printer backend.";
    };
  };

  config = {
    services.printing = {
      enable = cfg.printingEnable;
      # drivers = [ "brlaser" "foomatic-db" "gutenprint" "hpcups" "hplip" "ipp" "papi3" "pnm2ppa" "pstotext" "rawtoaces" "splix" "ufraw" ];
      cups-pdf.enable = cfg.cupsPdfEnable;
    };
  };
}
