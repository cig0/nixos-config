{ config, lib, ... }:

let
  cfg = config.mySystem.cosmic;

in {
  options.mySystem.cosmic = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable COSMIC Desktop Environment";
  };

  config = lib.mkIf (cfg == true) {
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
    nix.settings = {
      substituters = [ "https://cosmic.cachix.org/" ];
      trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
    };
  };
}
