{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "myNixos" "programs" "localsend" ] config;
in
{
  options.myNixos.programs.localsend.enable =
    lib.mkEnableOption "Whether to enable localsend, an open source cross-platform alternative to AirDrop.";

  config = lib.mkIf config.myNixos.programs.localsend.enable {
    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
