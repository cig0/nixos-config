# Don't remove this line! This is a NixOS APPLICATIONS module.

{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem.cosmic;
in {
  options.mySystem.cosmic.enable = lib.mkEnableOption "Whether to enable COSMIC Desktop Environment";

  config = lib.mkIf cfg.enable {
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
    nix.settings = {
      substituters = ["https://cosmic.cachix.org/"];
      trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
    };
  };
}
