{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixos.programs.direnv.enable;

in
{
  options.myNixos.programs.direnv.enable =
    lib.mkEnableOption "Whether to enable direnv integration. Takes care of both installation and
setting up the sourcing of the shell. Additionally enables nix-direnv
integration. Note that you need to logout and login for this change to apply";

  config = lib.mkIf cfg {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
